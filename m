Return-Path: <netdev+bounces-276861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHIgOvhR12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:15:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF93C6E03
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB3DF300847D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D283371D11;
	Thu,  9 Apr 2026 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7UwHxWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD87371CE6
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718898; cv=pass; b=lRF4+GFMINat2BhtiVE6qECQMr3Nhqn/0ArCaaxP3+//KgXGGY22hyAKBg+f64lwf7GxIsvBYyHoqGjBTmEplUnVgdFiNURQYvMRhAkeQ0AjtXLK2BFgo8cL26LpbBiPVOX2xRXCucsbGy+Mk73Kfj1o6dm+neuLJW7b+Q2RZbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718898; c=relaxed/simple;
	bh=4iUt0zn4Q/30RhWY7UBTD8IsvgTmDPYjJxV03fZG+vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEn6KWpQRnX3gM96LhWCX3KTrd9bwJSP3bTxl6PkWmSGchr1+C06LQT4IftgQ0JSzTZV4hSXslvzetLDfAKI93J66Ht4gTNLV26NIAkhMJuBA+GWa2rovIMD64kUJ2tkIYnA0SMCZD1y5V9NM0WB6/IUZSZQcqw+fxEYlpWlz+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7UwHxWw; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d8e11b948so6192991cf.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775718896; cv=none;
        d=google.com; s=arc-20240605;
        b=YRJD9sGElWHQp/E9dwNH5GXXBYtTXPXB+wuMBk4xNlR4hUz5zUxGxVW9RR1IwZc4+2
         LhXu1bLYlMTdkmBdNPWc7Qw5/tFRzlVY+iRWygybKBlOUzSRM+uOSDGFioLKeWuMAkKO
         Ubr/6ijHPIVp+uNSk/pG370OxIqZ0OEtf3k0+HHhF9JOMDr+rWam2ibfSUjgxwr7BwLd
         a6w5wat3J3+ht59TICQPdtqnOgNeodlKyDoCiKAzVAeWT/l3z3c3YKA9Lx+uIkaDFxFe
         aLyfQSjNfevYbymnYrB77+M+1KZyBBSPr/xiXOmlhG1ZePWQeQ+3SsUJWQ1q6NrxUfMC
         6m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4iUt0zn4Q/30RhWY7UBTD8IsvgTmDPYjJxV03fZG+vQ=;
        fh=5Fxcuth9GrkWG+hxZawzsZrIp+72c0/5wmXSt8W9wm0=;
        b=XymfJIlEA32h3MA1srixc6E0RZeimIHCcaKqUxwg2DEo1W0j50EcYEoBThSVY1GPU6
         k8S4nUwPYgjan6GD8mtxe1BkRz5nE/SDSuvq1R7rdmzQ0pZysiStWfqZTgPJkXFFNAeE
         XxgDDwwGIWCwsnNhIroCBJ24ihWTXPlILaaqpL4k4FoqAD6Zp7dC8H2sAA05L3LfJqES
         o1RDQQSuxmHqgdIY+R8OegHL//aj9dsQP1vIjz0q7WTvMmdu8SFmB35WI3g5bZeI48n3
         F6Ro+drX/iuGH47Wyte6nV0PUvqsbW5/z8HmPW9+i164sjydfQMTCt5I424oNqO7SjhI
         m0uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775718896; x=1776323696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iUt0zn4Q/30RhWY7UBTD8IsvgTmDPYjJxV03fZG+vQ=;
        b=L7UwHxWwkkUg8kxJOIw5hh+0NQ+rVs9jWVyZ8g7AXP5KzRaZnvffexAgRHo6ogIbCa
         OJHhNol3xgkhKk8oox44K9biS1kC9szF3rNK/lJOXgpVFxUC2OPjLjBrNAqWYWxdAufG
         8X7kvLRVAb6Qi457Y4NfbBSGVilt1mfMf3y9SpSoujCcIZTTL8+ko1+JKkbIUWxR3w6W
         PPhEQ57mXB9HH6zQ0in+eTcvqYkqUmSIXHIlve3egdpQHEbDwXs1jLq+ok1YMPSeTONe
         UJ80fulE7KME3CJLuCAgoNEMIeHf6jRmmjWTjtkiFqGQZHiMCz4D9Xj0TgLpGLXKoELk
         xbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775718896; x=1776323696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iUt0zn4Q/30RhWY7UBTD8IsvgTmDPYjJxV03fZG+vQ=;
        b=pkk2HKOeDSevmngsZyxXr/LYszDIl6MkjfylprGIT/dSbQaE5EHq2Msr0YTJMNkDt/
         y+yqizhxdS7H1x0dhyrXTUlelk6nsbC7BW8GHrB9QJcDkaAcSVYWgeaeLvP8k0Cb+Jzg
         J4iHQx2f4G+Ssxdcivq1Xc2sObDO1cNi4k9IB/8FvMy/+cwJIsnGbNjRtR1GfgXkOmFl
         8nKlFndWxuKqoxiR5GfvvZvWGmtsiMQFo199aTVuyswqhhH1vAA4nM5a6rtfknj4T++X
         8IzbBjHdZoJf7U2dTmwOl3qJH6VmgIYDWg+eFyonSRSxftFJFRBWf0LWeEuYUlWv0+ef
         c9pQ==
X-Gm-Message-State: AOJu0YzR6ZH/5/At4E3k1wXKTdkQNOJDdi2rCOawPqcmvMHRnWSAotx9
	sFxwG4VYsT6W2QDva8rPgVrdoxC1qGGzZISVncP89yYjddPtexjMOEC6KK7mMjTbA6rm5GwvUo/
	Z4ANbHj1JFF0ohpixcmF5H5t523VVJEhtIK7NzaXp
X-Gm-Gg: AeBDieuGsjqARv1Tcz86awQtWpZFEMCRd+QiK/PAFMVIPsYMh1LwEUkHDm17ckMdZfP
	Bn5o80siczrTrFlGqq6dqiWNWLgv9ZA7OEkMps05c5xGTseKj3Nl7rkaWWaJo6yMxcEDLpALxei
	G2DEMNc0kCi0bZXeBcplKJ1RKCrska5EAUdJqoR25HDursnI0hswWU5nDpFTb1fqifMStkE/b7N
	ep8m+c/K/sB0nNIlEdGc0IPR72pzIlhNIR/jltdzkAl4XhBrqdwFcUKcLeR2QB4TC6dWQmJOUUB
	pBrbdCk=
X-Received: by 2002:ac8:7dcd:0:b0:50d:8389:c3f4 with SMTP id
 d75a77b69052e-50d8389c6a9mr265411171cf.55.1775718895354; Thu, 09 Apr 2026
 00:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKapqNnOF6BO2zE0MwNeM2_Hchp_d-qDQffywCg7Bk-pMcFKpw@mail.gmail.com>
In-Reply-To: <CAKapqNnOF6BO2zE0MwNeM2_Hchp_d-qDQffywCg7Bk-pMcFKpw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 00:14:43 -0700
X-Gm-Features: AQROBzCzCZZWSxPDa3SJMzf20BOTitqjnxasd8l7xs07EK9j6zGuJxj3bE3lNbI
Message-ID: <CANn89iKq=oQOmvDtK-Vtr7r9yrD29cURgv8VOJ15mFHyJ0kXmw@mail.gmail.com>
Subject: Re: [PATCH] nfc: hci: fix OOB heap read on short HCP frames.
To: ashutosh desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276861-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E8AF93C6E03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 3:15=E2=80=AFPM ashutosh desai
<ashutoshdesai993@gmail.com> wrote:
>
> Both nfc_hci_recv_from_llc() and nfc_hci_msg_rx_work() read byte 1 of
> an sk_buff (the HCP message header field) without first verifying the
> buffer contains at least NFC_HCI_HCP_HEADER_LEN (2) bytes.
>
> The SHDLC LLC layer only filters zero-length frames; a single-byte
> I-frame from a malicious NFC peer therefore reaches the HCI reassembly
> path where packet->message.header is read one byte past the valid data.
> The same issue is present in the NCI HCI implementation (nci/hci.c)
> via nci_hci_data_received_cb() and nci_hci_msg_rx_work().
>
> Add an explicit length check before accessing the message header at
> all four locations, freeing the skb on malformed input.
>
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---

Same answer: Testing skb->len alone is not enough.

skbs can have fragments, pskb_may_pull() or skb_linearize() would be needed=
.

