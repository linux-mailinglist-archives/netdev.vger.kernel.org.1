Return-Path: <netdev+bounces-259924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNaOOLCzm2nZ4wMAu9opvQ
	(envelope-from <netdev+bounces-259924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:56:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9ED1715CD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE56B30152D2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD161CAA68;
	Mon, 23 Feb 2026 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZAr8HpH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58418C332
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771811752; cv=none; b=DdCvaCkrPuBmM/EAQn3KrBJWAp0GdHVd6Kr4JOGHJ8S8XL+3L2iaCrrdtHXV984r62oxBRw9G6Q8fP5oFcJxtd50KJu/ikOVg9xVYfPVS7ulHcxgYOnb3kCMNYWxyVNu8CjyTqFs+swW1fnqPTj3h/g5jnDEmAoUIlNYyBxVA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771811752; c=relaxed/simple;
	bh=Z3ojgZMFwjTSR8AVzblv2PUdH28uAd2J0RLH+zjamzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecd8EQL7o4XllTH7O9uJ150rpmO5qsOyKdlNO7xtooUcdKwvfI1BASV0Z0Q1+oBkaYDWOW/TPpTXVG9dJOEHvFfnid5QH3JwoWGfdCESHd/hnG16CESVZHig2BwHd6AqA+dKjLUKOcpGJnrygl4h0lsked8smnO3N2fVG/nq51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZAr8HpH; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c5513f598c0so1392476a12.0
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 17:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771811751; x=1772416551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYLMgxnhRDhS6IkKiyt4RiLyD1JMu1hdEP1SNpq952A=;
        b=MZAr8HpH77V4mHydHo/gc1iEuDR3nF78O7clSAmyRMXm66R4YHsFw1OYEcFzAHIGFQ
         ZtFKHR2y7yaSyAFDOvdmM3sikJCHpxSh+GXzZYB1wVMh5Othjg+OFoOS/qZ4rA+C8gS/
         N1Ia71NirD68pf3ogj4Kkx/yLIREGafJQrzywxIo5KfK0FBeUtdsPq1qS5/cgjOZBnND
         A02kx+0jc1ZPwrsXdF+mQNrffyY/VaeibqLznWLA9yvI6kz6KkvziKw1T8ngo63BABJb
         G/+lpPQn5KgaC1r/eSVtiaQdkuTSWMaAyaR8Ds0xVL5wbAshmDPd2BGxwhK0AUx/sujt
         AUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771811751; x=1772416551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYLMgxnhRDhS6IkKiyt4RiLyD1JMu1hdEP1SNpq952A=;
        b=fZwHbCxDM+YHTzB0whKcy/Ir8vxSM3Dag2wo3k2Qa/q0DrA9z4XavStOva87SCe/ij
         kFGHh4qZlowSYK32wWYZFEPi9xRQck4fKguwtT1LXNfLZzHZVuV8UMrJF5ysjpHMLX2o
         L7nopZxIApabWsl6y9FGi8F+TKGDCL2C+sl5EWcX6/YVsyYXLIHXO5mCKw3HP0bQ/kdg
         SOkIEbIOv9jtjiW5mz4KaUdUXlEsmjUEr1oJlvQrkYmqWammvZ3Citnf29AnT+/+2WYS
         X0WZiI+CRsSSMB03dltMp6SyHMQ3PQI7H9WWgDBa0pS60yayBwHJgG3eqLuZ8a04chDT
         kBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF84oedTCD2n+tnloQjbocHNzmMie2L5As0Rp0jeWrdKBS8A3AmBA6QRKs+xtCy5dZopxNii0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPjN28y/s1HP52jt96x5F+iXSEHGrRxvKHv34tAywHBh5gg1K
	b8MAXhDEWNhLtaJiIoV9mGChnvtFkmjNlAqWOX1URYHtQR5AXvApILbY
X-Gm-Gg: AZuq6aLDpUyWhVO3IFi7QKqW23fCpmAognLJDde6/fWcqjOXHyT6OA7LOdv0mak4OF5
	UiMvoKMgKI59C+TaM09Rz2DfKAfh3JDi7c67WFbR1lgE+jK/yRNGn6N4A5SBAQnkaBm1/9tDSz6
	L0jIcaTfUEXq8G9nsEoQzMp3OitCMYUytcy45GQGzfos36idjCD+uHvGHdBwicS4WLpPLSD8KAD
	B6oMcAHlSpEvQ0QndYuKjq9pFgLfsuH3LVXNzXveKXWoIIrCsi1r6LdGPQ+TFfXWIiHY86IW57e
	Bmw4Ihs5mIQCEF5D6OxUkP9oRW9LSzicsxacD+nwfNONYkFphljGEhnv8IzIdXMqWN7bei+WhHo
	UF9HMOLd+QLn4YBeDWz6CLVFUt+Omj67RFLU79kZyF6tGbRq/9cfB18XiwkXsj+orH99UN7s+5P
	IdW8AIJp3XGIpzOWl63QgD5BReZ6w=
X-Received: by 2002:a17:903:3b83:b0:2a0:ba6d:d101 with SMTP id d9443c01a7336-2ad74463a70mr68332515ad.21.1771811750817;
        Sun, 22 Feb 2026 17:55:50 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e350b4sm56286565ad.4.2026.02.22.17.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 17:55:50 -0800 (PST)
Date: Mon, 23 Feb 2026 01:55:43 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 0/3] bonding: fix 802.3ad churn machine and
 port state issues
Message-ID: <aZuzn-6vFrcoD9RW@fedora>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <aX_6jyAQaDoqsR3G@fedora>
 <39c1b386-e6ee-46fc-a653-f86fa21e9e9e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c1b386-e6ee-46fc-a653-f86fa21e9e9e@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259924-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C9ED1715CD
X-Rspamd-Action: no action

Hi Paolo, Jakub,

I'm not sure what I should do for this patch set. Should I re-post to net-next or net?

Thanks
Hangbin
On Mon, Feb 02, 2026 at 10:27:51AM +0100, Paolo Abeni wrote:
> On 2/2/26 2:14 AM, Hangbin Liu wrote:
> > Hi Jakub, Paolo,
> > 
> > Is there anything I should do for this patchset ?
> 
> My take is that given we are now much more near to 6.19 final, this
> should go via net-next.
> 
> Beware: it looks like Jakub and me are not 110% aligned on this topic,
> so please wait a bit more for his feedback, thanks.
> 
> Paolo
> 

