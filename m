Return-Path: <netdev+bounces-260207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKapLeXEnGnJKAQAu9opvQ
	(envelope-from <netdev+bounces-260207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:21:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C6F17D872
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 311FF301A796
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49836378815;
	Mon, 23 Feb 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VjzNDyBV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA737881C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881697; cv=pass; b=TtW46DEHgaOkcmf8+CY8GwxV0H3EGbWlVAkjjF1/FfBuRTEL456QLKvLURJELAHxBRpsN90oFfsJb89W88TIr1wueBB0Y9pZbQeamYoJfZpC+9Ah0h1FB1fjQ99jGvDD+xN6v7pw+jWr9A4Q83L9J5GDz5pPl9b06o9vwQycdE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881697; c=relaxed/simple;
	bh=hHm+p9ikkfNSa4kfw8h73WCQ+NLtLroz4jRv60zgkEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jESdzUScygpeN4ZCas7PFVhAP31eDDk2Q2bK/IuQobsMf1VLQBNdBwuBmLFWHu8NGxxnR1uGhtrtOC/3tOjVpDd5ZxtnVd85qWMy2mHlklrLLfq2OEKTE5vgISMoQl3wOPopp0GPSE3MIGI+wzmkvEtRgzqFiFqhipis+6b8suw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VjzNDyBV; arc=pass smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-8231061d234so3710671b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771881695; x=1772486495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvUSDs4JDhQj0aZarYP9Y0d0064mFU0oQdOA9eegABc=;
        b=L9pWCh3yns5D/zxBsI0ZtEV6h7ofENYWtspZy/lDmIYBmX0HnGdzeMFsTxdAIVFzUs
         FKOkpXXZi9CQ7G7X5Tm/yeoC//oYLl5GBppvKDdf+L5Khb+fxZFrx4IclJG4RgDXie0/
         MH2GgZBkAWZcXhCveOggiHlyzzoNnUJdXQ4/M8la7BMurWmAaLn/CmOOQlK3WiK6ghsk
         UY2vRP85YKajs9rREHe2Nfr4U9uiIKtwb4L3Ekr8l96XUT+pyiTR5nfKE4+yLFi+x9J5
         AkZwa3OW/vo8uA7glkVBnSxwBj/f3OK1z7JEcRYNpdIyMpdi6Bpi9rcnk9qhPATWZcB8
         VV3A==
X-Forwarded-Encrypted: i=2; AJvYcCXsyGa6U3qJHX4Us/Rkp/oNqZ1ojDTG+6rRxe7FopggO+FyTZI4HDlHOkzmter3F4S+pevJZNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBugOzyASE0Gi/XwVd76ARfMNRKCeGkzky7YBqBYdr1mgIvkh
	O1wZB79UbCx17rwlPQgsyc3i5aUH41qxjLPpLWFsFBjIYAbPMFumk+n17plKp09ufP/1gD6zNcR
	X+qur1l1p0JSPL/2eh/yRiyFffYwsugz63yPGRHX6cqb7jBKaR3IQi5M7Ao7ggTW3CV/zbcpOSX
	4qqZPLTvEdctLIi0nFCKtpMQhQ27nxlcAOonf7XhFyPEaE6lY2hwFnRkhd+3GaXjCSkJGVDPZ24
	MdILLn4zfM=
X-Gm-Gg: AZuq6aIbM2qOsdXuG2C7sAI1Uzc3l7p6puACzrekyxQDXnLjDlmzPEBh/PSVLeItwaD
	+SzB9/pXS+okfKSnsE6x+MuaPkmgBPY7peYAmU2QaPIsm8yzX2c4/vaoA4L/g+9cY3NqS2NnHiL
	M9gn/SXb3BbUyD+9a9OHhf7TKIsTpbZRojJ+zomV/Fb7fML6MgcgKS8acCi9SVRRmss2hLhyYT3
	EpjEVlIBAncayWF6n63wUeCEG7miz/2HoLfMVrJPktwe+j04sIZ0e0gXA9pT/2WdyOOb2LPhcda
	7l2qar33voedpPBw2SwFcbMXdurfd25jVMrGH1D9iQyuBDPirXsdHVS5BxqdzQTRAcYdn+ckdjt
	oHR9nOq9EC93bOYNJRhtHwqGiM+e9o+q5875EE4RNJXNUYGhStFTHmc6nd3afKr55bg1vNSFfXI
	CTDnfz+f84C7yqMeMpt0QqC3T9eLHasMhiMF96UlLmmoIhnQC7LudTplwULEw=
X-Received: by 2002:a05:6a00:3008:b0:824:936a:46bb with SMTP id d2e1a72fcca58-826da8ee367mr9867371b3a.20.1771881695310;
        Mon, 23 Feb 2026 13:21:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-826dd839792sm1059774b3a.6.2026.02.23.13.21.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 13:21:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b88632ba0b5so695363066b.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:21:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771881693; cv=none;
        d=google.com; s=arc-20240605;
        b=PdekSXe/2098prqElxIWQ5TGkCKVQnspzF2JbHaRalwokPUMG0HLmIkhY2LEuYdR/L
         hjrFP/O7FUlqspuc4Y3pg85djTO0Io1xmO1Si8DnMqOCK432pa4E0fSFhUKTyLvUzjSR
         485u58gbGX3B/re3Py2FAom05EjG3v6IEM5Q7YUbWz+9iRHgkRkZLr5b+8Z1vlcHZ6lc
         yQRTnOGoj9UHGz4pHO0AEjBY8qcHK3i4pXV3g8UrnQr4haV6+Hm3Jn1/rWS+4V6cSgdg
         PvaI5BoYU3W4nJHQWawwg0UGl7+ER9yuacEOhxj/sQdVnifvDnk2WeUDP0grLtuhxd61
         H74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UvUSDs4JDhQj0aZarYP9Y0d0064mFU0oQdOA9eegABc=;
        fh=VxeUSbgc+yBeTifukZ1FWFwi1/noRRJohahrIwYapx0=;
        b=eh3ta5D6S+2VwH4SFUcUKVyPjdUcAhALuTUGVHBhC06cye05VpQZoiQa6YdnUoQXVH
         Czhi6rZxHSO75ivnqKT1zrCYHD9EKRL8PrxP2y4XlBEzbDksVYcMi9Rbb7P1ARsCp5SP
         beTjnQY/otjlAjnOB7238Ego2z3JP7YG7ktXPZTdLgsMT3rC1Eg24jRqjUgyqKtHx+jv
         Th6KKAgGk4pPKx5O7JVnkvJjaqXUU2V5M1xgwtoPQ2VJhNRC3yYELK3ukeiyESZ1IPqa
         Vv9rebnCuQnsnVgPa0ipVaMluAoS+qlau/DpM91f1PWciQVKWT1mKIAkx6Bkyok458AO
         URgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771881693; x=1772486493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvUSDs4JDhQj0aZarYP9Y0d0064mFU0oQdOA9eegABc=;
        b=VjzNDyBVzimkexEPTJhpQBe8Y8NmgxQXThmfaKArQPUYw/lfITDqMPS4z4w3M9Q63f
         viUcsEoQ/GpkaxzRIIaheIVB3TXpso5wNrU5utzKrIZaRei/fPQEPnTvBvchLgkmgHWv
         TzBewz4lDsbjaeQKiumJOR6iciwPf644m93qQ=
X-Forwarded-Encrypted: i=1; AJvYcCVeoskbFJCH7rxoaDiQ8JMKRUScjrIiZXFzfkCM+v7y+31ZFzoePZB+1umaAzN6jCS3fNQ4QY0=@vger.kernel.org
X-Received: by 2002:a17:906:f049:b0:b8e:9e11:6615 with SMTP id a640c23a62f3a-b9081bbdee5mr599598566b.47.1771881693016;
        Mon, 23 Feb 2026 13:21:33 -0800 (PST)
X-Received: by 2002:a17:906:f049:b0:b8e:9e11:6615 with SMTP id
 a640c23a62f3a-b9081bbdee5mr599597166b.47.1771881692427; Mon, 23 Feb 2026
 13:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223203702.4137801-1-kuba@kernel.org>
In-Reply-To: <20260223203702.4137801-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 23 Feb 2026 13:21:20 -0800
X-Gm-Features: AaiRm53SNYFh9R0q8A155OL2wVeIAM1tx-Nj1NB8CklrEp9w5lXrgAz-r87_wCI
Message-ID: <CACKFLikq+Ng3ynp=Nb=nGd74gvGgf8mRqm+HXJH3j95RzeQi9g@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: rename ring_err_stats -> ring_drv_stats
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-260207-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 61C6F17D872
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> We recently added GRO stats to bnxt, which are maintained
> by the driver. Having "err" in the name of the struct for
> ring stats no longer makes sense (as pointed out by Michael,
> see Link).
>
> Rename them to "drv" stats, as these are all maintained
> by the driver (even if partially based on info from descriptors).
> Michael suggested calling these misc, happy to go back to
> that. IMHO "drv" is a bit more meaningful that "misc".
>
> Pure rename using sed, no functional changes.
>
> Link: https://lore.kernel.org/CACKFLimgibJ0qkM1AacZVh8MKKy-pE_AAc4KPKZ7GU=
qebmXW9A@mail.gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

"drv" sounds good.  Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

