Return-Path: <netdev+bounces-262147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P4/AI4Bo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:54:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D81C3B8E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35FA93032D4B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAD644A700;
	Sat, 28 Feb 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3Hl2TqA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA7449EDB
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290378; cv=pass; b=aNWSDhDGqC1VwI2qqKGOuMw+4xnuufjO07bWvEE8gw8YdUAla7LPFui5Ged4Lxo7r7omC4BbVyh2+eVTd5vlzG/z3UXTO4Wjcv98BgLsW6ic9PVLBVMSVUeWiU1103c4QPjM2txYX/QAA9gGsvovi14Vbl12efyuE8nTnM39kOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290378; c=relaxed/simple;
	bh=JwfEhz2D8dgPYSHCT1XgQGntI42kDdgWdxOF5giMnN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ui6cCSAnwj/OV7THSZVbDPQ7zoDoGze01cIIqDEiFBVLcPRzXU3jvck9rRU8hMVOk840b/BFvZms+9BsHlc+3TIW8evI+dhySzkDfxUQfL5jdHg8EbRi1+gNd4zXcYOGZMN1834tfuyiFsFJKlngZMARNZzfdU+trU/MKVENPts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3Hl2TqA; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5062fc5d86aso28220541cf.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:52:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772290376; cv=none;
        d=google.com; s=arc-20240605;
        b=Vgj3jSE82XhSaAoG4kuZXBZUo5NmO/PvYsQhePnSQ5N+KHIp2kh2soVR6dl7ZHGQ1c
         TxIg84xSQWG5TIPTOMOlzQOdtytsTuZYeGZe256ruc5GsK2rhn6g9QHJSVKsMx66VHpi
         jxqbP8h7DWWsHbwcjdWOhtHIzzoHzcMgZUM24qVJc0zZVqsap1ETNaINCYC3/rTQJYw9
         YfT+wi743FMiWrfIGZaePTQKWBwdTz/U7y51X/IciR2fXxzXmY5ikow3OAG1KxUgWq6G
         QCZaKXqJWCnLU+Jj7YyDTGlrkjdOOAfiUpAarNAruzIQ1jG9BWGEtxir5PuOPjTxaV1h
         ydZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JwfEhz2D8dgPYSHCT1XgQGntI42kDdgWdxOF5giMnN0=;
        fh=//FmGisMG95vH2Jo6N5xuQdRIHTTVNt2V8RBpjRrh2o=;
        b=k7z37N7DdTsURsRqjthWV3RTcWl3T+/+uPtbaxUWYKeUeheZPwoJanZxYkJpwdkqT8
         PRB4ZzmNob/tIsPuXBj5LIyOeRbSeXWVnB0ZE7rRhHxrTmtGoU8anSfDqvBO5Uvvr1z0
         HB1DzOOzY3Mp4TE1Mge8edA8tGrXlm1y2NmC/4vQZ5w6LVkjGSOgKDpOGPWYXSNFaDGh
         spdxloYi7Ob5F03FTkwFY/Zb1JKczqKzDKL5tjuarOca5qujy8YluioijVsVPszgLHZ/
         RhIvu3V+kVUxiTRfiKUVs+AHso0HswjEBcdjN+MgUhpQj1MiH/Oc+TLrclQImtIAvn5R
         h3Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772290376; x=1772895176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwfEhz2D8dgPYSHCT1XgQGntI42kDdgWdxOF5giMnN0=;
        b=o3Hl2TqAvM7Xg+6S9K9pyRAWDY4PzIsNMA9cIhioZ10+ZzlebcoPIIkeEEK0lzgC09
         /5ZZDD7LV4B9+f4AN9RvLzYGohujsTs2aT/pSQpORTt8xePOdG87q6rFd4IDeNfULX2d
         zWYS+02zLPpxZqxrCaCfzK2Se5kSAzpGMhOxrFL1Ry0zBu6m1LiolVE70vOrR7hCJ6Rf
         dtDw/D580Kof/Umt9drf6w5MYvOkAZMoziNePuZECjGW695O6IAfRPIkP0k1LmUQ80O9
         G6pRJUj51h6GVkw8BuKzeMRUCwecs7bmQ3LdZeU1dW2jh3q1ZzNdo7qeNzlGpFD07xSE
         ymPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290376; x=1772895176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JwfEhz2D8dgPYSHCT1XgQGntI42kDdgWdxOF5giMnN0=;
        b=BRVxtDLo7A6snuPC8s8hmOMaXu4oPgteACnla162u62k/M1P38ftFE2MhcuW2V0dnY
         4+RxT+gpX5CFmmRvtesoxJbaWMdm2OqSlmoiF6v49M/drm2GZkfKvqhEiI5u/WDONpfH
         I8sBtThB8PRSRhMwgwTxdQDWPB+8JPkLTJh/FMZzZl5SBMvQVL0XLOJEBSuZMXgcm3KN
         2XDYgevBeO/ysUV24CmatCt3vgzfWnFfapD/XNgB+CLAUXJKxn/PmTVvH7GIO0traOT3
         9vnDpRO4MTkOoiaS0Kvly2uveZRnie1e9QiGj6SSKszMLLodo7loQK7v0qmvSyFLWLFw
         cjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ObT+Iu7f8wEuld3HkJx9dyEs+xqIxkIOEt8JK73W955Fu6bMc8UaxQBzyZ/v3RWJ1MeDYsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4wU6xHKblLRYUJgdfDL/f08k+unb0JmD01sJxi6WxQ2wcekc
	pF6YYKoeB54cjalHdxAAjkG96pvV51DS5uSbJSESKKuRG2hPI1gaPey76s8iRWk4nvQsrHHGGDP
	r4Nv5FU0ctu1koWpkm+W5CW3wV5Cv7Bg3mdIYvPwO
X-Gm-Gg: ATEYQzzTQMROYY8bRPRWtwOZUvBvmi6gfe3VVgtkCnJDPr9VF0dcIbA0h8pqMgT7g0B
	J7O5h3ZjCcEVOUlpnwgDLe+KIzSN8C/VrG45qZbMEdzb1vRLtqZzDkL03bEGd8AJ5ujFrjUmSuu
	8QlUJj7JqBBadh3AWWzhV0e89kjewZhi8VXqu4vBr3NfE9ppapIxr4a6pXRil9BBZol3AN3cash
	VnxoGc/gFBvFYh3aaPXWF0QhA1ZoKNlVoXt8TjZf+gbrl+NrEzt6h+1o8sxEjsDqrXZl21Cd5F9
	MA2Vxc21
X-Received: by 2002:a05:622a:551:b0:4f1:c66d:4c98 with SMTP id
 d75a77b69052e-5075270e0bfmr86307031cf.24.1772290375496; Sat, 28 Feb 2026
 06:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-10-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-10-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:52:44 +0100
X-Gm-Features: AaiRm53cB9iPnVSaL_73-tsViEFtNL4NM2MsmSdqWjTgQwsqkGvfyu9jYUmieJE
Message-ID: <CANn89iKFQxCXkM63P4TLjyAsgg0Q_4AduSKZ3AZWmNvKnzwQ_A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 09/15] ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262147-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C6D81C3B8E
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> ipmr_net_ops uses ->exit_batch() to acquire RTNL only once
> for dying network namespaces.
>
> ipmr does not depend on the ordering of ->exit_rtnl() and
> ->exit_batch() of other pernet_operations (unlike fib_net_ops).
>
> Once ipmr_free_table() is called and all devices are
> queued for destruction in ->exit_rtnl(), later during
> NETDEV_UNREGISTER, ipmr_device_event() will not see anything
> in vif table and just do nothing.
>
> Let's convert ipmr_net_exit_batch() to ->exit_rtnl().
>
> Note that fib_rules_unregister() does not need RTNL and
> we will remove RTNL and unregister_netdevice_many() in
> ipmr_net_init().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

