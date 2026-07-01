Return-Path: <netdev+bounces-303901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W9hmBIOoRWo2DgsAu9opvQ
	(envelope-from <netdev+bounces-303901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:53:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B36F27DE
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:53:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MWdyE69Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303901-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303901-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED8703037809
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04F43491E1;
	Wed,  1 Jul 2026 23:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659B26CE32;
	Wed,  1 Jul 2026 23:53:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950016; cv=none; b=Xa+ptsf6meSibKLjzKYg67CrnHBMb3HIPTSMCSsJT6MR6MtpG/VgEx8qBZY0J8NZ+W3bAJDmKeF8lsBuxiSGEXF2kZp6xuu4W91i92pvYEEIOpZ5exVPF2V5i+A3jSW30hEq3hrJu2Ln1OWbHwILWm7gty+X0PSLZhTeLvkmEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950016; c=relaxed/simple;
	bh=KNSqXdpgheGfVhc2Ab18vWbJXmdOphqCpe53J8+RDMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXFFw9qpemcQ8A1vHeUMwb1qd9W7nFU3kaR9jNdSj9GGcXyJ6RiwHRbu3KQhxbqhz6Kys6HOHVRxaM1E3ezzzBt48IN5hlm7dXz/hGnXXK0k8nrqQrAUK+4oZZ/xq8icZwhqADATwT36rp5hz6b6A1BIcT1aQZfWsckenXpkgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWdyE69Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E571F000E9;
	Wed,  1 Jul 2026 23:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950015;
	bh=SfV/2f3NAL+W2OX/1VdR3LTuYKPCvxTp30dOIVYBcT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MWdyE69Zz6x+YTCCMxtplMnzkxr2Ln63vBGTZU+k+vG5K6rAAIOzxEolkPJq0PsSA
	 bqFU79OCAkC8PbiyXUJBQ13uHSciFIStIShUtIePuL7m0F0AISiJp4SjxWr6plkd4T
	 d9ost0GHAk5rUd0zewcq/00uUuTpQfIuQ4z1Wk7DAaS5uWbo4t9kdsz4JCRQw8YNcd
	 EcKwktUl4eHKdDFq+wkc0jfADgTsDj2ZPUQW74eqsABAXG/vksJJGFSjW11bM8re1w
	 sHjo+dzDCMQBj1rq1mZDpcCySJ0EtzrCNY8P14qO5K1tgHKtbItkUhdWmC8rWY3O8F
	 WYhKgDHbYG/aQ==
Message-ID: <6c59d8f0-9a70-46d1-bf70-1e69c1869fb5@kernel.org>
Date: Wed, 1 Jul 2026 17:53:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 2/2] devlink: support u64-array values in
 devlink param show/set
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, stephen@networkplumber.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us
References: <20260701031359.839221-1-rkannoth@marvell.com>
 <20260701031359.839221-3-rkannoth@marvell.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260701031359.839221-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 823B36F27DE

On 6/30/26 9:13 PM, Ratheesh Kannoth wrote:
> Add support for DEVLINK_VAR_ATTR_TYPE_U64_ARRAY parameters that carry
> multiple DEVLINK_ATTR_PARAM_VALUE_DATA attributes. Parse and display
> u64 array values in param show, and accept space- or comma-separated
> u64 values in devlink and port param set commands.
> 
>   - Show search order
> 
>   devlink dev param show pci/0002:01:00.0 name npc_srch_order
>   pci/0002:01:00.0:
>     name npc_srch_order type driver-specific
>       values:
>         cmode runtime value  value  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31

"value value"? Is that correct or a typo in the commit message?

You are dumping it as a string which for json is wrong -- it should be
an array.


