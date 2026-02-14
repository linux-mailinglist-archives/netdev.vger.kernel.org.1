Return-Path: <netdev+bounces-258698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKPVBYtpkGllZQEAu9opvQ
	(envelope-from <netdev+bounces-258698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:24:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54A13BD76
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBBE1301D310
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C3030B52A;
	Sat, 14 Feb 2026 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0dYZuJ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAD30AD0A
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771071880; cv=pass; b=tHIjnJljG3VCFQxsGeZ+/021cZXX+5k/A7E0H2LbzkiLQScJ6sLi9CdWkx/xNh4d2DZZ5mDGWQhRnm6ArjkdzBWf96mSsKVPuZp2uDRDVcoKGI9HjXK7f8cvzVxoDPfWbTOJmyvzC+tWqy0r7B7BaXCX/eWfEZi21OVXx+Twh3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771071880; c=relaxed/simple;
	bh=q4cxUOMCfCrqAwr+TojVQFPymtMs9sCnyVT0/hhpuUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/1CgvzWr8JRRLqbZA9cggOq8aclr4HCjnyfxt90PhXka8HIV49qiKDLgG3LAmnMsbeQsXVEE/om1qu72JB5UFiiF8kpTewy2B53ztJyGcIrIJBWVgTyCIwdKcsogpIF6Q6EH14WX85hMLn0yOIhecq58d4NyIFIxvuhBxO2Zaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0dYZuJ9; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-503347dea84so21077791cf.3
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 04:24:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771071878; cv=none;
        d=google.com; s=arc-20240605;
        b=lxOrB8m8vVt9lpg+ESJ+/BbrOK60QMDfHjhwFq7uChiRyNXV9Up4WOhtYwT/sOHh0g
         436B08ZJXG7lbzrCKILgMH1gld8LnPlFSpxub08SGqWN1zW2Q9YH6eexBjhoQzwK8Npi
         GMJYvs1HrrrM+x5GfN+ZFRarE4j9k94PngbjneZreHXs9rhn2F808rs+oSHKf2r1F8K7
         e8wK5hnhbanGZu4Z6d6+nRQDIwhZ5YYq2rwnWopUII13RqoN6ooh7ESRPZoLL7pga/C3
         LwllQFbgJ9pVktJFLyj0rdcisBCyVfh8N282OLf99GvxyCrbVkVBPy+yrqZEtZMicnvI
         1Pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sPWTyjs9tozXoPPAmQmRuCCI7Ivl22mO14D7dHHGmaQ=;
        fh=q2mEcYn48fMIopFhjCmQJeGNJCcCE+o/YMGzVH3JhYA=;
        b=XwUS7GZRiquZJDPtH/BqzV/gCpe4wJY1ejko6nx7CgVqPb3gvY++/QkVfYo6wlZzks
         30UjZN1VBF1hCeN3blnmJiZyo6SC6MKgBnPJQ+62LkvTRbiGhUCcHdJPWinc1PLyvGdu
         SX7DVrhM9NXBAQjNnGO9h6sehStLJSSY+ExOj2Z8+5ktCKwsWH+FXgBCGcih4ryqdm1n
         ZYNRK5y6dM3AqoKgH5e+OnKwciHFuXppLnlHA34PSr8Jptd6oQPqyZYfAsszWBOQ/7su
         VTEMY5clL28vIfPJyqOpkVDTYQtoRTr4uBz3s6WzLZkoCxaHdXXv6B/LVgcXsqNt86/K
         TEnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771071878; x=1771676678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPWTyjs9tozXoPPAmQmRuCCI7Ivl22mO14D7dHHGmaQ=;
        b=x0dYZuJ9c/0PbgDeJhd+EdfB/T6XAPYAyG4J8QJFdUxWHP9G8gp+/fx7C2FDqnCCGw
         CTDJQJOHGy2r6x+0aoOA2pLdCaXdbOjCp0ND8rl7fBRgnPP6Sda34+dUUKmoqzNqfi5y
         V0tm7JVJXbCJQrSc3aA+if2mm6dHsar2eRYYYBIebHTolm30vqIgf48q4avcSZ26G9yB
         Ab/L2ZBcPz2n4t33qUxrcRje9FcyA+iiHg5lOekva4hhudhMrn6Kzv957vgOKQQWXnw5
         Pc+FZLi675AuJsaM5C/QUSVSzT9S6pUiAlSX4CmqeKvDWpfJxRt2mMV1ly/QHtZTnePY
         zwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771071878; x=1771676678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sPWTyjs9tozXoPPAmQmRuCCI7Ivl22mO14D7dHHGmaQ=;
        b=A4Z9kOHcKucPoIDoJ4Zn6i8BlkWRviVUKxXuZ9DT+WoUOP6bV5CfJwnb0kKEy28CoS
         ehrzkHBwMFY1TPdoF8uHsosQKjSBJ0pwisBcGR5d0Aoo4XWoeQItyMlq4Vxkdimz8bpc
         BgYtH6FyteXsq64ryjAclB6HVzpukZdcOy9IpD9h9l/1lDYIWUaugkx2Icod+ajfCD8t
         0CyMa5qv7hGu45MNMxz68a8ezjU/5KvCoQbgkR1NfzHFawMYQej7nIVzkt55xXB2gZwl
         plHgkcvkamDtEHrOqWMpuTY8ZFfxkyv0T5RqlL568x5OIJJzo/HqVZ/XJ/WHYVtMenRu
         O1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlD8R56Q52ttbLjPTX4nHSxqe/pKbiRlkGGwVcUXXt85CUW3QCOY8fMeV9eN1eHkHWpQrA/2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKsV0Gud2LElbwKDJ6OcMq1Ci/2nDTl7cD8q+tGQTDFhHZQbk
	kEmiJQhyCeJ44EbfZteatv0Easnfvf3HoleHkpRxHkO3bLwPTGZuW7XJABQSo6/pYdf19P8lb4P
	6NSXzkyPcjcs+KXZ2dztLHiaiBWjamMvW9cqVV63eJqV4suwQZzBS6oBJ
X-Gm-Gg: AZuq6aLo4cw/kUCq9mkeZQ6grMezeBWDxlkdL7iN09bqRTJB7+rqrIJXB4Ua3dvcCVY
	ko6aIzCUmFK6L1EnP659oiVrn3bDiwvYsmHh25FT+P8zI5VmeVCXIZ2RWO1LwEpg7B5nDH4Ey+C
	zAE3MJVW4J9cTS51irJ3BBwfulL+usDU2I8vFM62Uu03QoZuDR8o3h6HFT/yDTRv3XDU+8wJ5hF
	bkfok2/IyhathIuOHkJsqPM0VAw6oGUj1hE11fIcbrcybYDFt/eYZBmoewxAf23ZMT0iIrqqRGr
	jbCevWo=
X-Received: by 2002:ac8:584f:0:b0:506:1c3b:c8a3 with SMTP id
 d75a77b69052e-506b3fa63dfmr37029201cf.27.1771071877607; Sat, 14 Feb 2026
 04:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_6C4DE85B2264772717871054@qq.com>
In-Reply-To: <tencent_6C4DE85B2264772717871054@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Feb 2026 13:24:26 +0100
X-Gm-Features: AZwV_QgV5MxgRMem_HGIt9AWJ5J0rfvRC-rw-r8Ln-A3GBEh8D1mAtWxIcKK5XM
Message-ID: <CANn89iJKp2sXJU5jO0+D8+5qTe4TWgzgZmCN_SDy0CwydWEfwQ@mail.gmail.com>
Subject: Re: [BUG] Potential Null Pointer Dereference in tcp_mtu_probe Function
To: =?UTF-8?B?5Yav5ZiJ5Luq?= <23210240148@m.fudan.edu.cn>
Cc: davem <davem@davemloft.net>, dsahern <dsahern@kernel.org>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fudan.edu.cn:email,mail.gmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258698-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 6B54A13BD76
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 1:11=E2=80=AFPM =E5=86=AF=E5=98=89=E4=BB=AA <232102=
40148@m.fudan.edu.cn> wrote:
>
> Dear Maintainer,
>
> Our team recently developed a null-pointer-dereference (NPD) vulnerabilit=
y detection tool, and we used it to scan the Linux Kernel (version 6.9.6). =
After manual review, we identified a potentially vulnerable code snippet th=
at could lead to a null-pointer dereference bug. We would appreciate your e=
xpert insight to confirm whether this vulnerability could indeed pose a ris=
k to the system.
>
> Vulnerability Description:
> File:  net/ipv4/tcp_output.c
> In the function tcp_mtu_probe, we found the following line of code:
>
> TCP_SKB_CB(nskb)->seq =3D TCP_SKB_CB(skb)->seq
>
> The issue arises because the skb pointer may be passed as NULL in certain=
 situations.  The statement passes the skb pointer to TCP_SKB_CB without an=
y check, but TCP_SKB_CB might contain a dereference operation on the skb po=
inter, which could result in a null-pointer dereference.

Which pointer could be NULL here ? Be specific please.

>
> Proposed Fix:
> To prevent the potential null-pointer dereference, we suggest adding a NU=
LL check for the skb pointer before attempting to pass the pointer to TCP_S=
KB_CB.
>
> Request for Review:
> We would appreciate your expert insight to confirm whether this vulnerabi=
lity indeed poses a risk to the system, and if the proposed fix is appropri=
ate. If there are reasons why this issue does not present a real risk (e.g.=
, the NULL check is redundant or unnecessary), we would be grateful for cla=
rification.
>
> Thank you for your time and consideration.

I think you probably should fix your tool, and use a more recent kernel any=
way.

Try to have a human validation before sending such reports, thank you.

