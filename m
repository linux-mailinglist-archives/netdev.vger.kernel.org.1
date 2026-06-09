Return-Path: <netdev+bounces-296998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id InjfCCviJ2oB4AIAu9opvQ
	(envelope-from <netdev+bounces-296998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B82B65E8E7
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:51:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=A4dBNN1I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296998-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296998-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6813330B76E6
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B90391E7B;
	Tue,  9 Jun 2026 09:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A666388361
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 09:36:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997778; cv=pass; b=StevjC2oUQOVr7mV0uvikyUeMmExxE7dUPuBBhywQ2dFzi1Kn43lFfNYlGYIrB8wEP5eKzcd2xwr0XS/YoT0t53bLNH6TFNYDFQKznAECz1yxJQY+iziHlfw2VZBaZ3r/lNJoufnRirD3ldQcla9PbRQ+JMfNQm/L1se37jlCm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997778; c=relaxed/simple;
	bh=Eb8MhuXa+k3Vx66xyti2/LygYTICXEV0gH0z76fItEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8nhTS+nvvxCUFlzB4ZVPI6J26CB9KvQfggNciCvtQMxk7QB4SqEt4j7yE2BRLwLZxZX6O6ar7fKxKvAClU69pITzr8Gjzg+mKQcAVuegqW1UEH6hnsMsajzqvEmXyhMaHalnVtmLywOBp3glyEmfENVqb4FzVtefM5wVxdjJ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4dBNN1I; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176ca6bab1so56595931cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 02:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780997776; cv=none;
        d=google.com; s=arc-20240605;
        b=GXLNJa1T4GuTWSzMvQpcGixknpUFyMaHSTTfL9HhWN61S7i1hsh4GoLWOVTA1FsEoj
         AWJYccee8GmDBoX66eTmOE3SVSoQDq4RcdaaKhShmTFOGAf1wrSODvbeB9lQ67CSKfPl
         8YuN93eyx5gsE2uTE0RXFa+wljCST4+y/Ro7yGULcYB4kbHnHY/sSD3r3yofX/OHqUJL
         p/bksPF/IFlSmQlEgpK/vkLA62ZXfV3iRW3KKH5/dgIj2uQDyh8ziypFAZtrU5dX4s75
         Ay2svT3rR9wiju6rmlGm++t0IgK87VdEox8gfH1l2Pz4P7Pem8RCWh1MVtuh1oWvKwqg
         3c9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Eb8MhuXa+k3Vx66xyti2/LygYTICXEV0gH0z76fItEc=;
        fh=0h4LfdVNJiKVaecOf4ZdCJjU/xabMCYxb61Y68Hqd0k=;
        b=dh52xYeu1v+FiOWR19tS0uCJg2rnabjStifa7c+qqP3kkW2L6fEa/Oq8pNKFQtKkZx
         0JXX51ljhhx4NWcNjq3rWiF5JKoyrCzlE0tzIrxJ47c72/1EOhaZz3vDqiSONzfQ6QbD
         yAvLKveob+qn93MBwx0b++/4phGd/N9vI6E169pjUyuTEk4luEfgVEvf+8lMxYyvtDM5
         fXh/1B04b6Icn5XKlryPYNVtHEOZvarDFOe2zjQC0UuhugUuBaO7J067CklDJ0l5Th9E
         HOoQKN6CpKU4tIyYLg6ekaSfzPcahqCDyWSFpfy3WgnNkUr/bm3ibEDF9bi1wjCPu0Og
         xPeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780997776; x=1781602576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb8MhuXa+k3Vx66xyti2/LygYTICXEV0gH0z76fItEc=;
        b=A4dBNN1ILMhmRhd6KMLiiQMGMieGB4M063xnWSIo71DX+WJFETHBvvn9J+5LbCiRBz
         5lSXYjRxoAnR8d1Cq7vYNvoYZQLwBp6cbvN1TSMylQUIitZHhxIpr/6q+483/xB0klHJ
         FitV1km/GMi/Iix4dsd5Wzuniah1kcto6ffWyEzjzdIjJDsKjBJmPSNBUdKFSZZhVkMF
         vA1XXzGe6+ba8AdnL0fxNEjScLj7Zr3N4rEx43dQ8mSWCdMUDsdmap0DJTF7GPsKUc9V
         yWbOsorfR5eXH4rUydHDX7RvwAhcOdPCdkcK93ovGnMtBvRvfe7RRauXgT8Yf7p+j+Vc
         6yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997776; x=1781602576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eb8MhuXa+k3Vx66xyti2/LygYTICXEV0gH0z76fItEc=;
        b=G6/cFmVkwhurw75XywoCvSI3rEny8kgE+xnbPPwTrApfUa2toR0OTkN4/d/PQdhxqk
         CSe1lVG/ZJ7PpuvZzb5l51//SxpWNBe042VGf3v5Uy6069GqLjIbbM6h4SPAUDqhnInr
         TicnhO5QB5xLgozjCEaNzUu7BPUHYtFQYA/w+TWwdXtgIYbyBkGXjNMs0Sc8antYzTyq
         WEN5KOVlciaGwKcdjOEeG7DR3ZAN8nplnQwIZiIZecAs0SXZzMwe3aQ5QJseO+o9iMfh
         yLbQacmP8LzM60ZAwlKDxsjlfg4cC9yoAiIYW1ZNZBOxY73PU8YaCb9savvS7dUpD490
         DBSA==
X-Forwarded-Encrypted: i=1; AFNElJ8fr3PN3RGIx5xFgibEor978I1LREcmT8Bw6EbFS/VOc2mI9t3Bf0twCRRm38pWozmQDhran50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6CqvkuPNEMUtdiGTU2AZsn3uChiW0vrvPmOyMLmufAfEtG7q
	eScaBhklPPNTq3RdqJHVM7LQHF//g8ZILLvOUsTyQ8WGjvl7RVuiuAcfvRsfkw1eOCQPBuBsc5e
	4N1NYnBEGNBGd2JhomEpChFzFoOmXLD7qdveCKW2jDLyHN5XG2XsFEGce
X-Gm-Gg: Acq92OHXsJJCvvUZrRSqwR5C6gS4ssjRW7qsvLr/j/QbFV1HrFswfhPbvxfZCRMO+MN
	yQLFJq1D79u3PS8bYxooKJJVEjJ6Y765nnpYpCNaLNyk9rclgHHP8iGLIUAjwIjNRT9NK56xkcZ
	ueVc0oIN+HRvlrCogBoazWZavW7eOXQz1hbweAkSEaP+/NB2Ovu9ZgawFzuaFJNmS+gLk7WgtDH
	AwIgNphzhxZJlwVuGCW1l2P/ryGc1NnfRmUZcOJvPtlwcz/IhyqOUX02gIVoO4HFkDY1VMIQ2Ij
	UWlx40ds+MU/bShoFu2yBNveQEDgcOMjpiMaymy3uwcaXYPZERU9r/TM8mkVF+ibGiTpCdOo1Mp
	w5xN5PfBatbdVG6Hctods4R2d98A/aIdsVUhtsiuf
X-Received: by 2002:a05:622a:5518:b0:50b:3429:a10b with SMTP id
 d75a77b69052e-517986d4a6emr194261541cf.12.1780997775333; Tue, 09 Jun 2026
 02:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609081113.7613-1-sigefriedhyy@gmail.com> <20260609081113.7613-2-sigefriedhyy@gmail.com>
In-Reply-To: <20260609081113.7613-2-sigefriedhyy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 02:36:04 -0700
X-Gm-Features: AVVi8CejGZnsSJpub1bEIAys0m8wcSUbGl1g9jWjK5_pZ64d3Rl5cgdavnm2nEo
Message-ID: <CANn89i+8MnZGUiP0cLT7wJLPModjj3UkUEp87X0SRne8Wcj2+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] ipv6: mcast: annotate data-races around mca_flags
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296998-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B82B65E8E7

On Tue, Jun 9, 2026 at 1:11=E2=80=AFAM Yuyang Huang <sigefriedhyy@gmail.com=
> wrote:
>
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU and
> prints mca_flags without holding idev->mc_lock. The multicast paths
> update the field while holding idev->mc_lock.
>
> Annotate this intentional lockless snapshot with READ_ONCE() and the
> matching writers with WRITE_ONCE().
>
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> ---

You forgot to carry Ido's tag? Have you changed something in this
patch compared to V1?

