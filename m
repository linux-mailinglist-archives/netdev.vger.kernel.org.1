Return-Path: <netdev+bounces-268943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFNiDhVxumnRWQIAu9opvQ
	(envelope-from <netdev+bounces-268943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:32:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A3A2B914C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 145623143BD0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E03B7B9B;
	Wed, 18 Mar 2026 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkkRsoWt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A063B7B8B;
	Wed, 18 Mar 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826050; cv=none; b=St4cL7ZrvoT+2akoEgU20th6WtzAOBlBAUISJlhczJq1ETJQ9ch+BXdWbBnI83gaY5QSUO55DHcLXptJohYn2iiZoaLt2XNJOzsYn7KskZrWdRRwuRLku4SweAfmDc2AhvFlGofFdvzLAUDOTpf06miRqGwmfWbwlwTD5ybPZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826050; c=relaxed/simple;
	bh=w9OS5HoIjwz7yKu3brAMZlMj2BZ/RzOH/le/2Eejb4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PtVCfDAB6u8IKuWcv4oR7+AXm2pNGivjI/MvV5P9ixsNkFVjSnssTBHEJrjmNVPgoUKKbjwrOVqwq/QITzjfcFssqV6SE0WYSLKgCA6jPWvPQ3mmmjKCEDcDosyAICvXacYTd1t7ESLne3MzLPPMaKR/50GKi6nVKkFEAueoXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkkRsoWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3238CC19421;
	Wed, 18 Mar 2026 09:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826049;
	bh=w9OS5HoIjwz7yKu3brAMZlMj2BZ/RzOH/le/2Eejb4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RkkRsoWtzV8HgRk4xsuUQ/j8bQwgeMVT4qPEF1/Rce/8dbZrGQrAkfYNrHedMXSz/
	 vrxjqWd0yTP0Pr3pY1kqNwAiK3yNdH7zeEYRDWkVaHHCK69mINklUA5whGKsxEGFyS
	 gWrkRKE0m5/VeOSaRJiEJFwuyqaPs+6EXWgn2VB6Y++86yr0FsSGcOk2/gRLLrDa/9
	 xpLOsTC/77JNRwxfhRYSvmICIXnSwNtwONE7JjNG4QnVE3ZypSnLR9UCJFFdQf0dMN
	 FDsdMluDbQYkpkaheYir8JYa/X2Cljb0Vao5t5A73AgGTLFTCgkdFU2FH+li/fVVra
	 B3Y6+Gu5sdzSQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v5 1/3] ethtool: Add RSS indirection table
 resize helpers
In-Reply-To: <20260317154636.78964316@kernel.org>
References: <20260317083339.2811865-1-bjorn@kernel.org>
 <20260317083339.2811865-2-bjorn@kernel.org>
 <20260317154636.78964316@kernel.org>
Date: Wed, 18 Mar 2026 10:27:26 +0100
Message-ID: <87ms05pjwh.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268943-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,all.your.base.are.belong.to.us:mid]
X-Rspamd-Queue-Id: 85A3A2B914C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 17 Mar 2026 09:33:34 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>>  static int
>>  rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
>>  		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
>> -		   bool *reset, bool *mod)
>> +		   bool *reset, bool *mod, u32 *user_sizep)
>>  {
>>  	struct netlink_ext_ack *extack =3D info->extack;
>>  	struct nlattr **tb =3D info->attrs;
>> @@ -685,6 +685,7 @@ rss_set_prep_indir(struct net_device *dev, struct ge=
nl_info *info,
>>  	}
>>=20=20
>>  	*mod |=3D memcmp(rxfh->indir, data->indir_table, data->indir_size);
>> +	*user_sizep =3D user_size;
>>=20=20
>>  	return 0;
>
> Weak preference for return user_size; instead of output arg, 7th, "p"?

Good point! The 7th and p does have a bad smell to it...

