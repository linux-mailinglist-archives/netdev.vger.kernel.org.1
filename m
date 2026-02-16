Return-Path: <netdev+bounces-258817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CgyLSNokmkltwEAu9opvQ
	(envelope-from <netdev+bounces-258817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:43:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1890B1407AA
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE8D300CE5D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F82571C7;
	Mon, 16 Feb 2026 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+RIbPgG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA21DF75D
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771202593; cv=pass; b=mhgOy91FlfBhc0uyBAgP5IdKhK0ivqYS0hx/3SRSmKHiNl0UY58wSrC8Yjq/EFVAJpQsXshRxr2LxBwSSqNOnD3BLSgv9zGXBfwcWBRLmGkXwyMEYrEXWICS/S3n6R1q5M4wRwf76/PglBdv1SpNyAh5fKE7MqiA2ib65me7Lw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771202593; c=relaxed/simple;
	bh=jF+yQ8hRJ6Fc8ELS1OKbRAV21beDmm0sMR1bEdG7Vk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sa4jMoj/G+krWSdU4pJ8fNj/CQbOiGu4zv/9c/UJOIup/pVPlph5oaaF5jOo3b0mI9pEnVw9AFN+om4XF1NEV9iN8WdHwOEPcKAalvqhtgXMOBnVFapW5v/RdkloBh1Kx41fd3CuB3j+XRi+jiNrz8h4lQw5sPHdBG9TVuhZkaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+RIbPgG; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2982705eec.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 16:43:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771202591; cv=none;
        d=google.com; s=arc-20240605;
        b=hYiI67BfPTTByR7E3Mkj7jhwLybx75u2R3cSqggVFsoN7vxNdyhFZUIry81LRUnJit
         Yqn6CniDDw0/MBTZky8Dv2dWDf39OscbspG8iX0AQnW/EOm5WdictlrSE8S3xyZg08wr
         Mhw3gGwvI6fpl+Skx0Cm7JwyVGHtjDSXA4DxYRf8FfcOvwTSHHESUsq1sMNKN97qedu1
         raBZcCimTDrxkUepNq6+LYCOfFSgEhbQb84V0X6hR+aBmQrvJSx826MtjQFLlSQ1SWmN
         WhsP92kE6sOhoD5DGo4IRd7YrD4HKvXdw2nVcXWP+cwA0GpCtBtxQekvosHt70fH5ibE
         Lahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jF+yQ8hRJ6Fc8ELS1OKbRAV21beDmm0sMR1bEdG7Vk4=;
        fh=Q8OGlJV6UY1DDKaiMcFniOJDQntZaFD9bTBMCjNiGE8=;
        b=UffG4J9gV644IBhsmv7JyfXvvScDMDOY9xLfsWPmA1QwOZXd6GUEHh7If10QUmKv0u
         3bgKAH2E0ER8b+XnWHt8q+ANM3oPUC25zgLhm7EWuuB54+VXWwyBO94RTx81dm/vEju4
         gxjmU2UJSeMpjIkwtnOO8uK3S9z+lO4id4qj4w+n2DNGCelVZ026XbjY1vx7F/2eVUG5
         /zqxCLw26cGlaZgm1rxrdu7RZrtQHCcucGnjVwcVXgkGJbiWeGKBvlgUt1lrmV58diJz
         YdMLYUXQGTrQg/ltpt9fiPeudUV4Ga2AA7rK8Jp/tyQJ4vlcBwb8xxGqpRgpW5F4nv0l
         pL1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771202591; x=1771807391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF+yQ8hRJ6Fc8ELS1OKbRAV21beDmm0sMR1bEdG7Vk4=;
        b=a+RIbPgG+CWR5kW3JPp8vTVUM7XzXrVTe2vpBJXwqK9z5l78tRYiO8I01cS0LIWIj1
         4p2kVoVWVsifQKSWt67kUf1VxApq12rPtVrA4Fzno3PBcMRc46q+M5Z4DKdsE13cjqxi
         1veWpw/x5PI9NR51qEL3x2/fC6DefWTn+1fiMi/oCz5fX2d7Y1jnSsvpelgB2NYIJJ5E
         Rlxt/bzLOuS/JPxaXXwa0vUGecyWj+MtDgHibh5GLCOyn12wCvUi/NbZ1jKdaTpGV9HE
         fjC3tZQpCAqQ+6iRlOEJmnKyuIotGec2w5opn9tnPppGQ48ANG6nKGUcfqTaf+QEWfN6
         XrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771202591; x=1771807391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jF+yQ8hRJ6Fc8ELS1OKbRAV21beDmm0sMR1bEdG7Vk4=;
        b=OUqSIjTfKQlZ2Y3Cj8vTzng8+C9GR+GydqOo2wnxDTFOIN4milXoUg59zz0Nd11zAE
         32Im/VT9YvS4usraSCGkXdTRq7DKQAAosaoovLU1TtIOiYYcMyFWcdz9tAcuB7RsrZzi
         sTpSW67CHBfoiM2UYSX/gO1xAdG5cqj7Fyl96wEfGDF8T+coJaPTUTv22qwPMkUoHnnZ
         GyKrv6LC22M58LgyRh4KI5vD488C5rtjbpDneBRsTfDouNTUabahQU193lQe7KTiQ60k
         wTXyU9thkU9fe2ZlXENtMR9HF5onE0LQ0usEu+LxDBpfiZSyENrORL5gWMad4gUNfywj
         G6nA==
X-Forwarded-Encrypted: i=1; AJvYcCXYSm0fuaoL7SsOq46jGXBbZAGy9HOJqUVJHEpozr3aFL89hHijGnHzasx4Jo9XIuUY4Mj+lkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywle7/2d4ZIK1Tla0IUnY5xMyfV7DTxjwvjIqOD7cMfsajdsUMG
	HlbTR/+cBWansy9odtK5n3x/tj+i9pJQGyrs/hdrmlfnolEJOhWh9WICmi+u+Mk3G5mOt1vl4uZ
	wTE/a/rf1zbq0qgoaOyOHEu9VKh3iieQwc0n5dXK2
X-Gm-Gg: AZuq6aJAu7/+Vgs+CqhW6RbVvdAYv6yq1ihaZ/OuIP+0lwTgiJokc4NU3Fo3Z+nJkdF
	ehqkuntDfRbF25qQIvSlk2AloQlXxSKrUYzus8uRFAEpRiTw5cp8J492YeU7n80zoLAM+hB5kjq
	lDX5mL3KjSigi0PxGhM1SkRKWZTNz2rSKJbsX18MeBlU53poz2F0+zTsWvZlkiTHPl36o9Bkt/Y
	0Ps7REOp+teP4H5KwCZ1Hp5xKnGJ4RE/Pn9P8fOtOw6DCPDCGUc0o4JNp5hruSW8eqoW3kIdK2y
	8RSv9pZDiymuKAIVDXvHLPCAi6iDzfoQXsnp/dE+u1Uy3JIngdBpOdcCIOk8qxxeiLH0yw==
X-Received: by 2002:a05:7022:f102:b0:11b:9386:a38d with SMTP id
 a92af1059eb24-1273ae81364mr3882598c88.48.1771202590509; Sun, 15 Feb 2026
 16:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com> <20260215143821.2330791-3-edumazet@google.com>
In-Reply-To: <20260215143821.2330791-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 16:42:59 -0800
X-Gm-Features: AaiRm522uD6c5Sp90vH0yMrEfbnLkoahi-sTZgLBYb_NZO2oRGobcAc9T3cTLhk
Message-ID: <CAAVpQUD0BQeipSEDMDq43sq_EnNv-wcXiP9cEmn7mWwmHQmRzQ@mail.gmail.com>
Subject: Re: [PATCH net 2/5] inet: move icmp_global_{credit,stamp} to a
 separate cache line
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258817-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,icmp_global.credit:url]
X-Rspamd-Queue-Id: 1890B1407AA
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 6:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> icmp_global_credit was meant to be changed ~1000 times per second,
> but if an admin sets net.ipv4.icmp_msgs_per_sec to a very high value,
> icmp_global_credit changes can inflict false sharing to surrounding
> fields that are read mostly.
>
> Move icmp_global_credit and icmp_global_stamp to a separate
> cacheline aligned group.
>
> Fixes: b056b4cd9178 ("icmp: move icmp_global.credit and icmp_global.stamp=
 to per netns storage")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

