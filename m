Return-Path: <netdev+bounces-261089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNtEFChon2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:22:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D219DCA3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BA38301411E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9830F7EA;
	Wed, 25 Feb 2026 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uwZ/wCKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2E223DD4
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054565; cv=none; b=apf7Fpcl0UeG4NE3O19oRa6M+XjoUuSbYE6lIa770Ufr/9pKtjDWDy+KDxMmxAFaV8WwMnTEdXs4gr0sNraJv9CceAw8YQD8UtrU+jKMqG2O7/OIAYJV5FEdUXU/Z0q2p0zK+L9AjebmEIovaY/Z3er6eT1IR5V7kUfF29SmP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054565; c=relaxed/simple;
	bh=uOBpExV43q0oD6CkrFpJuRHou/jN5DyGY6iAhyLfX8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfSoV+wuZJGrR4hbtWoqYnixxgRYtq99GG3ybZuki7blLydpcWaEP5P9vErtCFQprPJWgG0B1TekW4Hiw1fuo6J4v86tydOHf0SIXkc4EX7S5RbZqdu2M3MPDz3WRI+dQhf9B+kDima7I/Otfq4793CGSmmKC6kfvJjYDvwl4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uwZ/wCKG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb3b3e643dso4234085a.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772054563; x=1772659363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxH1/Ug7KHoIXoZ/9Q65N888ZlyiIRs//V6tziN0qXk=;
        b=uwZ/wCKGaG2KI4WRWApnykxQp5QUwCCZG/NG05NkIPQjEJlL/sbjY1dA7heqJEc4p6
         lmH39kBlRb9VwL365lj/AZb3vIlu/UZKYCTK4jJww1XcFMJ4yIfwlcx/hCDooWFrenoO
         5gi6mYxYVoD0CpUpaG94hZ/EoDdEM2NLQ1JZ8D6BPzZ+Q3MWKjzBlooqQbRROdao4Tgq
         eo5eoNsi/7nJFT7YXMNfi6KjPyBUDSOe+z4jbMa5nFJxmV7vgvinhB302UoZiHzSb8ec
         pUQ4UAEY4fQyzCd8VLnL5vQZMIk8BFw11wqQ8yDplWoKG3TvNMcoqAa87Ql+FX54N7th
         m+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054563; x=1772659363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxH1/Ug7KHoIXoZ/9Q65N888ZlyiIRs//V6tziN0qXk=;
        b=PQFwBxMg/wXEP12FpkYGyQOuCIn3tlz8mG1YLe0A/W1CkcQbAzKT/XqhLJSiK8ueGa
         q86gmmD+7871cAhfYp/Az9ugX8GnT6Mg10lOJkVCF4hi1rIlWvrLc4w3aTQNnLQTdHyg
         AWfWlDtDHZNROwefd0JrAzOg9dzjuG+zgiJXd1Ca214vek/+Opc1QJdA5ihlZ93XeZLa
         C/5ruqCmum+zzNwQJUXw4DcCulmjw7XEEXAed3piuCPYpnNzL4vnUuKpaE0BwgnsDlkJ
         LdnPGZYBySuUdGPt+m1GnEzkr8zhv/w8n7J+SfLo4QsNFj/trDap0ydmUnrrX3O6XIDW
         TlEw==
X-Gm-Message-State: AOJu0YxIwx7lEBz44qDw5VSqJapdH/xjDuMN+VC1uKpZrGilmMo3IaPQ
	a+YTX8BmT/ZOBUNzEBxc5luP64CiZsviP7j2JtP+14g5QyX/Zh3AlaFDftSy6vDL9w8=
X-Gm-Gg: ATEYQzwDfmjyLFzGWU+M5YuTCId/an/AgaTuPyw5dhHOyCajkTD/7wqT8fShFmworep
	n8sCnntgIyVNwE3ORl9Fdvoz88Z3nPHMMy0jnSSfX+KRfLMKRFhDpNgjXbmHbEPooWQPnYlT+Rc
	cuEkS6hbjdYgxSnfTa0c9d2EJDwgHKrr6VIlx7bmwIXrrBH7tRmlYLwJSqaQteHwksb842QEV3K
	H0v+hESKB8OnOFc5P4eKcts2CpUzzxcGa9MuXWkdMyIfQ6JXYSWJ4Z6WSdMhuBjXz9Tca9I7hOo
	fX5ldZKvuYbVecjvm1YaghFEN8SA/lGHE81FAVZw7vv5RboeevWhNUoksdasHw5+ayPD/BC73oT
	kq5eN/DaGKEFEGTaY25+tHP5LwRU8HF5coT9iAoQqLo35a6Cm+Zrb1pe6wlMT6foObegg5ldgWW
	L1mCcaeFK8c8oH7ZyVGi28rDzm8kyG3rsZNA44l2xUDnTpYek7KFbLFcN6FPcYxeLX
X-Received: by 2002:a05:620a:28cb:b0:8cb:4128:ec3c with SMTP id af79cd13be357-8cb8ca8205cmr2112009385a.64.1772054563202;
        Wed, 25 Feb 2026 13:22:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf64efafsm30011985a.6.2026.02.25.13.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:22:43 -0800 (PST)
Date: Wed, 25 Feb 2026 13:22:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] iplink: bond_slave: print actor and
 partner churn state
Message-ID: <20260225132239.34fba967@phoenix.local>
In-Reply-To: <20260224020215.6012-2-liuhangbin@gmail.com>
References: <20260224020215.6012-1-liuhangbin@gmail.com>
	<20260224020215.6012-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 846D219DCA3
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 02:02:15 +0000
Hangbin Liu <liuhangbin@gmail.com> wrote:

> +	if (tb[IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE]) {
> +		__u8 state = rta_getattr_u8(tb[IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE]);
> +
> +		if (state >= ARRAY_SIZE(port_churn_state))
> +			print_int(PRINT_ANY, "churn_actor_state", "churn_actor_state %u ", state);

You should use print_uint for unsigned values.

