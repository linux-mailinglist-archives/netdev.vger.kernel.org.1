Return-Path: <netdev+bounces-257297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHYqGCnuhGkU6wMAu9opvQ
	(envelope-from <netdev+bounces-257297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:23:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D9BF6CC2
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD47C300460C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0533326951;
	Thu,  5 Feb 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VH182sKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E11312824
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319394; cv=pass; b=jA0zvsmYUgCpTmDpEpDKkrHIUNhpb73tL7VJL6LB/aCmv1mvGttpEiHDVHUR9g+R4LoMADKTTHaYNuJlvvxiJ8c7YgBleMleg7xegqYkMrVGeiv1zVlzrm3M88ov4591E2Y8n2Cx7+n2HRHtl7UaVKGgYZlvxEljTidukT16ZjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319394; c=relaxed/simple;
	bh=+KB/WCww5GZe9+8e64zaqbMUUHUcBCDBPQsWTUw/JD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pb5ZVMiHFlDfoLMkBBjIk3xc9b+82RNvHAlFxcxp7uDQHscBbSUsgtU5k4QWdBz/HRQVps1hAQVtXqdACNRX+kTAx1m08pnrYGkKhDnPwmwJl/FfogDjLoneVateiWmGbvrybv9s4XHC58MAcTXNLFRKYJv4dFJBLUFXcv4nypM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VH182sKz; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso423436a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 11:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770319394; cv=none;
        d=google.com; s=arc-20240605;
        b=eoOXSrH3JVIaePwEgUDKyooMkeYwiUSbtJ3Xr5BKJ2o51lU7BYEUxKVlJalaIqAhyC
         E1f5Wes8f161LG2xfYse2FmXWDkcUr0PanpbPo0Mc7SQF41q8b3Iw35FZgzDOXVegUsU
         YmltS6NYoPsC+Fv/A28UzgYF67mPCwGYBkHiXpx21UjG0kkup9T2ndTw3tKW+CbaCI0E
         UOF1wSI04AZIlJ8YX7J7vkeMqMIOrwvITm9f0AEZd/POvFDLYRNcWr6yw2frtaZ4VRCm
         DWbTosE0yvKMetkzYuqo3EGqG1q0oBjuyFTYoDjE3mU6Jz3B7UMpmE47bnna2iWBy6Rz
         9vIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=diGxg2jNY0j0oExl7OtnTEe5rd9LU0VFb3TqIX2FO8I=;
        fh=d4E0/JGLb7cqop87rtoTr9jMnmRekyVhyLEvye5WE60=;
        b=dRosu+I3+f0Rz8/aPttJn2EKiP2RPrAwmVqH/uB1QbfudtA3bfhCiPnWeONnzNnY2j
         F46F0G5OeQCIxuUYXQPRsTLjskYLkOJllKmLpwcl6kpyM47ER9yNLdeeif7t9Vz5FOA3
         DlrebW3Z8m9rQaaoaSOtuLKX+601pmyQKPM9rPDihOGe8Co+Ep62LeqpHVwBirBU30i1
         IWgIebJWmHVRxxusjcxHbwrhu9okhql4B990IqlwX0V6p/BxS0FSvv83g/yaAycr9Bs9
         fl6QTttpMCstQD1detgZgPUtaIWFcdL2FFBCTxEv/W7cD78fFiqcYV3VsHG+PentD2wR
         G3IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770319394; x=1770924194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diGxg2jNY0j0oExl7OtnTEe5rd9LU0VFb3TqIX2FO8I=;
        b=VH182sKzXUq3p6+8qYqcFPd3Cb1ixpeShIm2s4CjPKQdrFwiGaxtBSGgDIxJyk1+yV
         vesVO8u9/0a8EnVwhpDtIxE9XqhUfeVYQ6MpypRsHPinWXBg2VxLqU8UZ/aRCaRErKwr
         Ea/+26KbzRVMN4OhEnWAqThVr6kV18Hv0Aea5kSLtysZ1VEwIzgmBXeTt2PFw6kL9lBK
         qyGAdfN6dPkTYVS3URyhU3Ht1cQJrexw2URIKDXP4OlPtTkDC03TbKyAyPX4aqRhm+I3
         52+6eGifVJhfDYZjhOdUT4emyDRdYImsDXYWwidqeyH7/aG9xwha4wJEHWgdvgTz6le5
         1ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770319394; x=1770924194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diGxg2jNY0j0oExl7OtnTEe5rd9LU0VFb3TqIX2FO8I=;
        b=V0lbWgxKJ9dy8pNJeChJrVg5hp71SC+UMumqn64pqqWhEAiCOzAM+uH/tEAme1ZVx9
         gHADg7Jygg47mBBOd10fobub4l3YAWbdMFDi9e+dzLisdgn5TdvjUkAxZaTEGi9fGGId
         9KYxNhazHw67ZEkS5ahERxO3tRD1vbdtAC8o01UKSZRt4ySUJeHUOqXVCkyMonWd+Xkp
         15luKOBiaAvnfBYJ9G5m3vFRHHMBDzIK1SBBDq2/5LkRgIoAliYejcvgUVdHBZajZlUj
         qeARfItFF3s4DqavQ1+/sNzJnYZXQ5qsajGgevp41dRyTXmG23yI6sJMiKYLgJdVmQym
         M5Dg==
X-Gm-Message-State: AOJu0YwSHpFf1NeusOUVqyimOmvP1+J6MI+LhS2JWJXCBusi1K/QtjUf
	IYlyKOH0gcIyC8lL8/kk87EyDRfExYrR05mO/lcqATYHwuJ/fziLWN9ntK1Gx+/GspQScJcXBV4
	jHqKxjgs9cNFdvs1WWIiv55NTUGh96lZmkxQYJg9X
X-Gm-Gg: AZuq6aIVCc/sA+V63VBqyVmaeVM4Sp197+0+oFqKgtMBvTBeW6/YGp868d1fUNKSxHp
	sE+Lh4Nm1T0dIw+N1xNnoZs4cnbGDAb3qE7/YGr/EQ1UUn+ZNn3BL6ZdDrRCICFbmOP/FImw3PQ
	jglz9fWOC95NkcngK8bQQHR+yc9dEpEnPIgcPUMEt0DCrupCMc9fdaoBsVds5NGhY4IAPs9J7Q1
	4x8alN05BPtXkewcEULD8bZv7DxNkCdnC96ShLwfaMwBm/wwM/vDX93YSuFjb/FeHtUu+XaxOkI
	PzM=
X-Received: by 2002:a17:903:32c1:b0:2a9:4c2:e51 with SMTP id
 d9443c01a7336-2a9519734ebmr2625475ad.55.1770319393945; Thu, 05 Feb 2026
 11:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com>
 <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
 <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
 <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
 <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
 <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com>
 <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org>
 <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com>
 <JLZxnCN_V32FjW6UUERYLlLtbbzDCDUmB3LOJ8ovdzV5pbUuGMRKi8K7ebh1j2yDt1u3A0pc1y4Zjjsw6-c7zucKHasFnfvYjnZ7hvT7aR4=@1g4.org>
 <mFDC5blKe5Rmv7qtNQvSSWDJsCdSd_lgeq681gEcHlSg-i8Q3-ZJSDqZfQV4xWFou75jYXgndoO-OE_4-_JNxPtT8rOdAguM_Xwl-qX8B6A=@1g4.org>
In-Reply-To: <mFDC5blKe5Rmv7qtNQvSSWDJsCdSd_lgeq681gEcHlSg-i8Q3-ZJSDqZfQV4xWFou75jYXgndoO-OE_4-_JNxPtT8rOdAguM_Xwl-qX8B6A=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 5 Feb 2026 14:23:00 -0500
X-Gm-Features: AZwV_QiDWszgQ3VqVTw6cQ8o75fZbyqNiHDSRaKBnIbbESVUQ0uYsNPySDFhAqU
Message-ID: <CAM0EoMk75BJYQUXm7FDW=ZmRsUqib3L+9tEAL90q_+DreroeXQ@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257297-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,nxp.com,intel.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 75D9BF6CC2
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 10:13=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> Looks like pedit might also affected. Hopefully this makes it more clear.=
 Going to wait on more input before doing anything else with this.
>
> NLMSG_GOODSIZE =3D SKB_WITH_OVERHEAD(min(PAGE_SIZE, 8192))
> SKB_WITH_OVERHEAD(X) =3D X - SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
))
> nla_total_size(payload) =3D NLA_ALIGN(NLA_HDRLEN + payload), with NLA_HDR=
LEN =3D 4 and 4 byte alignment
>
> Per entry size for the gate list:
>
> Each entry is a nested TCA_GATE_ONE_ENTRY plus five attributes:
>
> TCA_GATE_ONE_ENTRY (nest, no payload) -> 4
> INDEX (u32) -> 8
> GATE (flag, no payload) -> 4
> INTERVAL (u32) -> 8
> MAX_OCTETS (s32) -> 8
> IPV (s32) -> 8
>
> So one entry is:
>
> entry_sz =3D 4 + 8 + 4 + 8 + 8 + 8 =3D 40 bytes
>
> Fixed overhead for one act_gate dump:
>
> 1. Action wrapper (RTM_GETACTION):
>
> NLMSG_HDRLEN + sizeof(struct tcamsg) + nla_total_size(0)
> =3D 16 + 4 + 4 =3D 24 bytes
>
> 2. Action shared attributes emitted by tcf_action_dump_1, baseline only
>    (no cookie, no HW stats, no flags):
>
> TCA_ACT_KIND (IFNAMSIZ) =3D 20
> TCA_ACT_STATS nest =3D 4
> TCA_STATS_BASIC =3D 20
> TCA_STATS_PKT64 =3D 12
> TCA_STATS_QUEUE =3D 24
> TCA_ACT_OPTIONS nest =3D 4
> TCA_GACT_TM =3D 36
> TCA_ACT_IN_HW_COUNT =3D 8
> action number nest =3D 4
>
> Total shared baseline =3D 156 bytes
>
> Optional shared attributes, only if present:
>
> TCA_ACT_HW_STATS =3D +12
> TCA_ACT_USED_HW_STATS =3D +12
> TCA_ACT_FLAGS =3D +12
> TCA_ACT_COOKIE =3D +nla_total_size(cookie_len)
>
> 3. Gate specific attributes inside options, fixed part including TM:
>
> TCA_GATE_PARMS =3D 24
> BASE_TIME =3D 12
> CYCLE_TIME =3D 12
> CYCLE_TIME_EXT =3D 12
> CLOCKID =3D 8
> FLAGS =3D 8
> PRIORITY =3D 8
> ENTRY_LIST nest =3D 4
> TCA_GATE_TM =3D 36
>
> Total gate baseline =3D 124 bytes
>
> 4. 64 bit alignment padding, only when
>    !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>
> There are 7 attributes that trigger the 64 bit padding:
> -three stats blocks, three time values and the gate TM
> -Each adds 4 bytes, so add 28 bytes in that case
>
> Putting it together:
>
> fixed =3D 24 (wrapper) + 156 (shared baseline) + 124 (gate baseline)
> fixed =3D 304 bytes
>
> opt =3D nla_total_size(cookie_len)
> + 12 for each of HW_STATS, USED_HW_STATS and FLAGS if present
> + 28 if unaligned access padding is required
>
> The maximum number of entries that fit in a single skb is:
>
> Nmax =3D floor((NLMSG_GOODSIZE - fixed - opt) / 40)
>
> If PAGE_SIZE =3D 4096 and sizeof(struct skb_shared_info) =3D 320:
>
> NLMSG_GOODSIZE =3D 4096 - 320 =3D 3776
> Nmax =3D floor((3776 - 304) / 40) =3D 86
>
> 8192:
>
> NLMSG_GOODSIZE =3D 8192 - 320 =3D 7872
> Nmax =3D floor((7872 - 304) / 40) =3D 189
>

Seems arbitrary and I was hoping you dont have to change iproute2
which restricts the total size to 1KB.
Earlier, unless i misread, you said you are looking at IEEE - what
does the spec say?
If i am not mistaken, the spec is   IEEE 802.1Qbv which unfortunately
is behind a paywall.
The closest i could find was a vendor talking about it here:
https://onlinedocs.microchip.com/oxy/GUID-82119957-1E11-4B69-84AC-EF0EA08F5=
595-en-US-5/GUID-7E7509A4-351E-4D82-8266-967681BA2644.html

And they seem to indicate you can only have _one_ off and one timer
per queue, for a max of 8 queues.
Since Po is AWOL, +Cc the taprio folks (Vinicius, Vladmir).

cheers,
jamal

