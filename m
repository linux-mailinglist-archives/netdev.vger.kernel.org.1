Return-Path: <netdev+bounces-257992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJnSIMRZimnnJgAAu9opvQ
	(envelope-from <netdev+bounces-257992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:03:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D20F7114F44
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626E53008760
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 22:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEE5248F5A;
	Mon,  9 Feb 2026 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnN9WIsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6362475F7
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674625; cv=pass; b=sF2lR1+TloUyVT4d2ab5FobK59fKg+rG9RDdwF5JwwU7dGw0bUannamG0IdJ+0ykQUOoxu24w+emnvhdnHSeDh6jHCwtHHhkKJrruMU8XpMT3G+O84th6xpWDnUN3s2tsM61Q72Jr2dfbTa/IYF4JAAMJ9k2PeKuR1jyRT+bwqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674625; c=relaxed/simple;
	bh=8oTcoiAsuWwNHHquFzoCG8K2pYe2NkigqIs0+SPsMOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAo4KdjpGifw7j4AdoeVNtFv8PyaC+e/eJvCSzVR4p7qjASjjRbKZFlzrUYdGhFFvpzYbqcjV0r+/4UspMM6uOCuqxlswhn3gCxF+Y1ljeMtjn8+b7w+UrQorrljZVs3doNuQPdHA9cYub3xAT7MkqcdXHOpNMT8wfRTJcb/i/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnN9WIsN; arc=pass smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-5028fb9d03bso39617551cf.3
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 14:03:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770674623; cv=none;
        d=google.com; s=arc-20240605;
        b=hrKM89kBbsWXk/HaDvZOrW09gTu+CrZlVD6bIy8b/FClDanf9Y6B9bfdmH1SxluGxp
         5jDlsyHeplOHvVszHbETeB45FU2L+W62MkZFwmmyJVRvoZksQkgZ2dmV63LwBU3EHHVl
         ViV5t63HXOrtnIkq2H4W/TxgcC5UnyfjJ5Fxa6WVapz5loVGXVIB6sK0L2r2m3QT60Kk
         saThoJT8HMeMk8f4zbioARDyZKnG2YEiLv51T0P+WLdJY+JPkfgYLBUbbDTbXj6wOTk1
         0KclEiELE5mlG0sr89yPHkJigP9e+sU9HoRQ+kTJfXkAwcPpZENwdnUGoLoME8h8YQOR
         RZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8oTcoiAsuWwNHHquFzoCG8K2pYe2NkigqIs0+SPsMOE=;
        fh=4EaOv6br0N7mOeKRa2Ppv71Ir9HjwYc4jVy0IKvZFg4=;
        b=T1AetQ6dNlVtyMPuv+tQXVYUhzS7sSU0FKJw7RqXZ3PaQhZ6zdy10ECY3Y44bpHl5e
         ytX/AHsTcDXq6AOpN/OlERjOL8UxE4ce/pCX2J20pQq5uYm3wdIMluunD7vP/Momfjyh
         4Hw3TyB2DSpaPrycZfV82EG82OJmkD6FBetfdwd15QmIjVtryAe1/TT51sbk2aEhIeTW
         IhLT3wt1v9FK3JHzTgoWqfljtDRg9W81N6clw6e7KrFjSnTBJ8wDTBFA4kaZjeQzPsLc
         ZfP1wZW89zzz4dvET2YuOEGUXUe8q/R3/KONnglux3MOt+DRnrV1DsqAdRRnaHm/mPLf
         CjYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770674623; x=1771279423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oTcoiAsuWwNHHquFzoCG8K2pYe2NkigqIs0+SPsMOE=;
        b=cnN9WIsNkpnd30H4BFmDn9/xEriX4bucMR/f06cxdounNzPmJ/8B+biXYiaxzOWTmq
         q7oNGDHXAy+a/PI86rXS2I37qnwgtikQBqHFuGkajoAG6f08ke0ybUkJksL2aXdT0jGm
         ZRJsR2LNkoO5JT0VoooT9If1JKEzDt/hQJATOE4NdBD2kER1D0d8mKlLxnOkFjrve6lm
         ReKuk1+DqQEUPj886L6y0w7Xc8+rMetklBcpnsEgtZMTSBA+eq4rR0GZ/9LrRYKlnFM9
         0cmFUtuCFUyRGX1vBYkAaFxrmVLp+9G72tRYxefzibXwZd8yVA0LuCq1ccHW+YgRW0q3
         0JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674623; x=1771279423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8oTcoiAsuWwNHHquFzoCG8K2pYe2NkigqIs0+SPsMOE=;
        b=iz5f1bqy7WYY9BfdLR9zWnaLs7BqBjjjfAS3ToDwICpYTsrq2kpc/pSZrL78n47Hwe
         qeC//O6+agFMJmwyRpUOMoJ9EjUhZOKrPtrhGTE6zEk2gKRMdtcfnt0r+Krti+OIhQld
         nJ3jpTdHO0o+XpTyyzI6juaUJ0zjXDRaCBwRVlW3bLOcV0dmEyneFO2KiTu5W8IHQCV4
         ZnElkuV4M0cBnkIPSc/FU9aLOsHDyIRaoNCWUYiKAeTgbDY0YYxQS912J0ZDp7jwhMf+
         3bHH4q9p4DWhnbEVF4OpFI4RoRhgdC3cdoaLDKHm2LSiGpeUYTvmtTN8F2K9YvgynORR
         gQQA==
X-Gm-Message-State: AOJu0YwGfnZTHxdo1UmaYhjLUuyXggpjsm4F47nrdBE9XE3+rnOVRQve
	hmvARZNIF+gvUQet9IgYCr338iEwko5d/QvMyjUfsRkoiWk7a4Su/k4P16CqMeXMHnigC2R3h2x
	JAoQz0qcVeMnZAQ0UuR3hA+6rxO8TmCg=
X-Gm-Gg: AZuq6aId6Cf/ixCHGWw8Ip1RJDVVAiMIfXZ4nqmX8nrMNkqj8s8kkCoG/s+RHSj/vnz
	HNUn0YueohtgX2+WH6e/EE78Rgrxibl+CLbDxr6XDL4/VR5gEozAWNl17VBNHm1oXv50a1eFxxi
	rXAgFU7EkhxbCNiP77by+rNCzD0k4Dw+F77cRDkyiIBy45SyIYSX8N0TZ6kCMiBIIkKLG/JvqG9
	xJLKBvQLFaWzOCM8rOaf70bSBrL75CijR3SxuUhnfHrHHeWOwXMynWTaHMRGF+XFvVe/1MoYf0Y
	mlF3E8KVStRmZ/YMveP2EZHlIJF1unGg8eK5J48P/W839ZYvfTx5m/EKqLIgJ9Ab4KBr
X-Received: by 2002:ac8:5841:0:b0:501:489d:f3f9 with SMTP id
 d75a77b69052e-5063994e652mr188392861cf.43.1770674623468; Mon, 09 Feb 2026
 14:03:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205070632.37516-1-enelsonmoore@gmail.com> <aYoFT0QgeixLRfKv@horms.kernel.org>
In-Reply-To: <aYoFT0QgeixLRfKv@horms.kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 9 Feb 2026 14:03:32 -0800
X-Gm-Features: AZwV_QiQDUWvHhF2uhceK9axLFIBadyrtDTCas5nVrEuEV-fOSFVGQIzgq4ues0
Message-ID: <CADkSEUh_5mXi4x_7RXyBuXVVcKHLve=BTq_0-DdLT2PC-BbQ0Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: arcnet: com20020-pci: use module_pci_driver
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257992-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D20F7114F44
X-Rspamd-Action: no action

Hi, Simon,

On Mon, Feb 9, 2026 at 8:03=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
> I'm not sure that I see the value of cleanups to this driver.
> Which hasn't seen much activity for a while now.
That probably indicates that it has no major issues, not that it isn't
being used. ARCnet cards are still actively sold by Contemporary
Controls and SOHARD; ARCnet is used in industrial environments where
its timing determinism is important.

Ethan

