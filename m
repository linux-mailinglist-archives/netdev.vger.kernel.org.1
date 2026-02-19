Return-Path: <netdev+bounces-259523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D36L0lEl2kiwQIAu9opvQ
	(envelope-from <netdev+bounces-259523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:11:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B3160FA9
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D37302E404
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0115834D393;
	Thu, 19 Feb 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bBUzQIfi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872734CFD7
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521067; cv=none; b=GP2Qe2Ia4r0RwUZz2unJhB3L5i1mcfuSr5htzZkZFNRwv0Z2cGdF7VkD5LQWE7fhUIXLLGXTTxC/78JXhvauLsChnv5NFnq0PAPlfrECki1dkFp7U/rfuEqBBv+KQ/r38VQyA+iVL66JdTfL0h9jyPOXooXgQfFzG0chKNXSBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521067; c=relaxed/simple;
	bh=p+0yoUYOgqdCSsNYmHj7zM+lo5ChPaixfv+pRNVOGdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fh/c827xyiYWREsGTWFqtgOGJCuNqMRH+pBENZYcZT0MJWfQZjSeRvw1v1gSFZtT9sj8x5hQ8WKJ8RpUi4qeJogRpKQNrymw+0Q++k+PW0Cu54jfjnWQxR5ZVFC0qiQiWedE6mc5UunHAefqaIca/eHQOmU9vBVQGZ+YxidQIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bBUzQIfi; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-413d8b8e98aso505615fac.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771521065; x=1772125865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyrjZBaOYWnsTcDoFAVLra9VVv9NrS1xfuVC945Eoh4=;
        b=bBUzQIfiAbbIMume12l3+0XQL1Dc1qJNDs28T8gU/j1601zRk63JiPYRBrk14T2lpJ
         XCr+o4VN0MpvsHKXco0qXacrrIcaMrf7wSUfJVPi6M+2+PNIeZO9qssDkcwpFyD7caNp
         qnnrlg1h1FiLf3dJ7ccslCL20xgtFLSV1xTfpYWO6iJIJu+ajAlU//gesRoVwVI4McTQ
         6kJhkuXDjE/aQYhM+xwpK65boHANaeFMgsyZBambHTWBirblqYPrwNKLZu3yjG45XtTo
         gl2FSLeGkY72xlH8+h83Hu1WG57xrdLgKWovzJYiC7QosJMoI1JqZsyyMhX4e/UUakkf
         SBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521065; x=1772125865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyrjZBaOYWnsTcDoFAVLra9VVv9NrS1xfuVC945Eoh4=;
        b=Zdf4Z6LcmMs9ykdyKSzNZpcFhACc6swIpmfTMOxMw1n95+7Dw0qd44B9NjHdP7JgZH
         OpX+O7AmHgjEm7Xy3901SIHTKstYeRUi3829AByJXPGSAet/XhWtEY8kRw6qQCfeToTn
         ZmE7yJ+3sL1EBgrH4YZcJTonikIPnLIWQQ4uZ1b8dnHup0Ql1IVjIR6r4TEILsAlRBVA
         ekWEJsHPxhdgbR+5PaVXn9WEGZFPLZn2EebK5hsNMFiv/Yk0l3FLlX8530D+bc4MvVFp
         1ywXnYEf+OPJahWDHwfLXjqMlxTPwLU3Z/kQuu5jqHn8UVw1CYJLGuTdl3X4EguhGD8y
         YZCA==
X-Forwarded-Encrypted: i=1; AJvYcCV5+lsSQVHrqDJ0sa4DcK4aFO0XbeMLV0WHTb4DYlceGHdDN2JrOAPS+21nu9FGQLzojG12lHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsmznc2eCxoXZ/M9HympXul3xMNEStp+jYN9OZ7GBtSH1boSlI
	WVd33NLOyImBO/7/ZtYTUi8BIltSbHAT8UUC1Ze3BJ7dKGYTPWj4Bc47tHA4CHFIZneeOXgJz9R
	8Jb3W
X-Gm-Gg: AZuq6aJ5gcl2nzSRhNwFHUVHTKS3Ps7KsUhXOoEF3ls6QIeLp3WjzclPdm2XaZOI4Wr
	WiE//TiLy4OohMVaRA65VX/Z4B09pDcI/LyONxRmvbhKkbxhuDpobqzn2nd6zPJ5d7/MvISZpmA
	zhWCizlGnyINU/XBZ3m2Gq3SjIvaUySrFhE4OexnjjqA3kcfTa6+b6AP3LuSkn4ZWdeaLy8gso1
	n8rNmpdGabrOWodnPkKrU/wGhddW4qxMOihR/E8fAn170oKgm4/bWIgxwfofvw1d77C/GTIZ9Up
	Px0EhXvYQ2RooopPk5Skoy8FsdSINzSww1UgPXBhrpCW6U/Fbni9YDAYKs5NiXaVMajZ1HgNV+s
	XrskL2HrHrhIrv3MylK8DMKkoa8zXpxifiAgrJMAGnqO9bB47evooWF5QkZpn329wfab5Uc34d6
	WcYDj8vmMG4fE2wxG2y+GVPlyvBruLIdxCl4Rcn9p+XSnStamsUYM8SSdzylqI8vpZ
X-Received: by 2002:a05:6871:7508:b0:3fa:df3:b198 with SMTP id 586e51a60fabf-40ef3b771famr12402059fac.3.1771521064925;
        Thu, 19 Feb 2026 09:11:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaf178c1fsm24492608fac.17.2026.02.19.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:11:04 -0800 (PST)
Date: Thu, 19 Feb 2026 09:11:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2 1/2] mptcp: monitor: also show iface name
Message-ID: <20260219091101.551377a9@phoenix.local>
In-Reply-To: <a44c1f27-e9f0-4f33-beda-e5f611197e35@kernel.org>
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
 <20260211-mptcp-color-v1-1-01832777611d@kernel.org>
 <20260218103155.486d20ee@phoenix.local>
 <a44c1f27-e9f0-4f33-beda-e5f611197e35@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-259523-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid]
X-Rspamd-Queue-Id: 0E0B3160FA9
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 20:03:20 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi Stephen,
> 
> Thank you for the review!
> 
> On 18/02/2026 19:31, Stephen Hemminger wrote:
> > On Wed, 11 Feb 2026 13:03:17 +0100
> > "Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:
> >   
> >> @@ -530,7 +541,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
> >>  	if (tb[MPTCP_ATTR_TIMEOUT])
> >>  		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
> >>  	if (tb[MPTCP_ATTR_IF_IDX])
> >> -		printf(" ifindex=%d", rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
> >> +		print_iface(rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
> >>  	if (tb[MPTCP_ATTR_RESET_REASON])
> >>  		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
> >>  	if (tb[MPTCP_ATTR_RESET_FLAGS])  
> > 
> > 
> > The whole monitor message output format here is divergent from what other
> > iproute2 commands do. If you look at ip monitor there are no '=' signs
> > in the output.  
> 
> Indeed, the output is different from 'ip monitor' (but similar to 'ip
> ioam monitor').

IMHO ioam monitor is outlier as well. Should have seen that during review.

> 
> > Please fix the whole function.  
> 
> Doing that would likely break scripts parsing 'ip mptcp monitor' output,
> are you sure we should still change this output format?

I doubt scripts are parsing this weird format. That is one more reason for JSON

