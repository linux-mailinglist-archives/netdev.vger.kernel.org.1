Return-Path: <netdev+bounces-293887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIeOJhfRHWqjewkAu9opvQ
	(envelope-from <netdev+bounces-293887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:36:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCBD624103
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 243353016C63
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795EE3EDE41;
	Mon,  1 Jun 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9j0gkKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D973DCD9C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338963; cv=pass; b=Yp9BygMZo9C6QgDwdoSjhQBU44E/LXFT2wyAUuJVGhkVYcHbyv4VDYvUZTLL/zRkwtxEq3840fKjRoqU9jJHp2On0nuHmC6AG/Fq2R/vv9prp6OclpBmFXDe+hnaMKo2Sa0/xvG/5un6sdDnumXIgiCx+aXgg9ecB3KdE+s02BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338963; c=relaxed/simple;
	bh=tW+n80YqXWXisA2JxkiV3x0rRgP6syl0zR1ywIwYD6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEmDyp1d0bMs4xF8TCyHQGLuZrGmc78T/GiV8qKWVb5tUaDF1p9dYMpcumLpZiSyt08krV/DuXlUhM4ZPJxTim0ujG46MPR9ykX0FjD/ee8Wa0qv5HLnIECUJpwRB5HbWNdMTcnt4zd8sVrPZe104eceputCZ42lVCENk708b1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9j0gkKh; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137335bc3caso8754797c88.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780338960; cv=none;
        d=google.com; s=arc-20240605;
        b=dWhrvp5ysIZafQ63XG9SnCJbdWv5/CppeMFejIbJt1SuATv2Q2NmKbgMYTlW2uYX6/
         yqOaZlXOmyG8UVTFoR1mHyN08J79jmA00PTVZiwjiu9s97Hv9YfvneIyfIjq4Ae6O1WQ
         R/xvv5X6rVF5kb5iCzVbLNpY45TacdDw/CgoBmjDppj3tsebuCFs6qQcW3dkrEfvtn3X
         CMChnkCsqq9XyZn43vIrAFksI2QFn9tyPM84lG2CKFgvjCF+orB5zv/ctYDtFcusf/e1
         kp5C8Pto1599WzEqX3t6qpwOujDibRjGExuNuIFuPb3avWfdEp/hSgO4IjQNIG2YNC6w
         hCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BZCQ8JTHKVYt9Tclu34pPLg1XMbWxAq4Delwv/3YvpU=;
        fh=9OkgYkouZtBCbGdOz8WH3HAZgWtKosOosAKGzgjnDl0=;
        b=ZD1TrKZhR40GMpgRSERDkjVk2wsmkMFy/EAdaQ9e3OLec9JArRKVQMoz0NQ3L858Co
         bruYtWUoWqHT5TSQT70mLP1JdmI4/QuB/6Gr7/lL+IPHAiwRVGayZMALl1ThFjQ2mzEG
         JtNUwMN7hQyppclZqu/8EmBbrBWFruppuUBNWUcVZHGaiT58lbFl2S/WHikt7Q9OYQUX
         TEtioGNh6WexYlZErT5Qu9nkGPNpr62+yZQmXE+RPvP5yIbiQEn5e6xvkH/JaZTuL456
         PaqHT2/2MgBXur8xsG8NlQlWBKkV+MwtxogmcGHYwZ/MY4M7/iSRaO3kHVqTuGkfqHOi
         mong==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780338960; x=1780943760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZCQ8JTHKVYt9Tclu34pPLg1XMbWxAq4Delwv/3YvpU=;
        b=U9j0gkKh7L7GjWEQ9PGdXBpm5jzTggg/T4DFqYFUx6879h0LSP26LQyG6e+QBrbTWR
         adUjhtKUSjauEop4pZKr4arQMzRjK0NzYNf6Hgy3LAClM9fzEdPEZTlOxH2CihGt+9pV
         u9K/sWPMXktDPlZQSnvH9IYoObhTsjQve+qxRqWhqrp7j38SW8A0qosbtu24qpyM7jBi
         Vly+xx4YVYuSQLfjo19ZQ/zxxcRPJrKLb9ghktC754nLPt3MOohsQnWQ3UfoT+WtMnQq
         k4Zr9B/YfnZTfZoD7C9pzZlK5K98pJDXvodf8MaZ6z1t0qxQNDTA+a2eGukiMqCRbhCd
         VaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780338960; x=1780943760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZCQ8JTHKVYt9Tclu34pPLg1XMbWxAq4Delwv/3YvpU=;
        b=FdaNXtk0Qsm3Popo6zMKMXkKxknkj6+/hMPvodKOvSntuds2ByunJIb8a0SRFvm6lr
         Ydo5/rsyxx2aVuZWLFDfLL/sB7/f7f6y6T7ygCgWTcnU6C97e036W36ZRHAu2r4pksZr
         grOYUPlWpL5SJ2qAcLkOJ3KIAJIJxGDKS8ylQUkh3INZmCyeXXNLHVWHrQYfn6MHXP1B
         tP6YqWxC7fg8CAVFzEfn95ijOEdzqxrcX/zWzzg7PeTlrAzELuwAhZEU5mrZt8Hcbz4/
         8Er+0O6g0USjSLelETbdpmaGJI4H4wlmzDhwtjQMvkIxXB8orJlo7ubrWmGOfsaNqV4S
         IiDA==
X-Forwarded-Encrypted: i=1; AFNElJ+29iFnVwnrj71LtToTMhfK2JcuKBrP1pWuOVs838bUOQ2hRM8vrEyQhQp8pVbJUobCcZUi5uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrFFipw87DA2gXEen5BKo9+u1+rpRxSZNSR95ib+afy6e7IyW
	u1a0ZHaPHqI/tNPrIwtWZAbv/pm+MgyhBebdLkIGQcUA/5X3Ftd9OYvt70dCg9zhYlwhMUgzJ2F
	cv3IK1PnK78LH62k8ZK41qOBoJWtP0V0IF5J0o6S/
X-Gm-Gg: Acq92OHrQQgtgH7qrp+WMoKVBx54+HJw5njDqHUD73umtr+sMLKXVpV8eBUQuIJ5f0q
	Xr2KXAqHeP6HnccciF0MMlyMySfbMoCvwK3qM7uY5MrIGZCY3IQrq8MOKIWebMH7FfN3IlHfw9h
	K6tL7n5Vy/hsxXEvHwlLa7uMIuVAga2ylGxGah7iHyEdJ3uoO87jRVNvqitkefVjzP/gz79Ip16
	Kxt0djhaXCsX0p2QaO3IywXkaZMqek5pW4pRM7MR1XM2zE6Tw0lJ9GUVn7xX1UvOmPdvxaMDghW
	hm2MH8qw5No4rLLTOCMLLPnjgHDVf+/St0O1Vw96eTtGI/uu9Se/8K3zMbGF/Fbwq5Yzo/VLKj+
	XbMKEBPFCFlllv/6kkVjOpvM5cLaZ/uGL8xW6spf102gWmoPfCaxYhqEMyXHn
X-Received: by 2002:a05:7022:527:b0:136:7d65:4edc with SMTP id
 a92af1059eb24-137d3f183b3mr5189541c88.8.1780338959580; Mon, 01 Jun 2026
 11:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601113640.231897-1-jianyu.li@mediatek.com> <20260601113640.231897-3-jianyu.li@mediatek.com>
In-Reply-To: <20260601113640.231897-3-jianyu.li@mediatek.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 1 Jun 2026 11:35:47 -0700
X-Gm-Features: AVHnY4Jo_WRYBs9AuS4ymSPO1yP0VwgvWsTZn-utNlzkeWpRmNrOKaUMo6nfXHw
Message-ID: <CAAVpQUAk5Yyidp6YQwWJYzQfZE-q_2RLKc2eTevmdzSXZ=C8gQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] af_unix: Add test for SCM_INQ on partial read
To: jianyu.li@mediatek.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, black-ch.chen@mediatek.com, 
	ivan.tseng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-293887-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 4CCBD624103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 4:37=E2=80=AFAM <jianyu.li@mediatek.com> wrote:
>
> From: Jianyu Li <jianyu.li@mediatek.com>
>
> Add test to verify that when a skb is partially consumed,
> unix_inq_len() return correct remaining byte count.
>
> Before:
>
>   #  RUN           scm_inq.stream.partial_read ...
>   # scm_inq.c:165:partial_read:Expected remain (512) =3D=3D *(int *)CMSG_=
DATA(cmsg) (768)
>   # partial_read: Test terminated by assertion
>   #          FAIL  scm_inq.stream.partial_read
>   not ok 2 scm_inq.stream.partial_read
>
> After:
>
>   #  RUN           scm_inq.stream.partial_read ...
>   #            OK  scm_inq.stream.partial_read
>   ok 2 scm_inq.stream.partial_read
>
> Signed-off-by: Jianyu Li <jianyu.li@mediatek.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

