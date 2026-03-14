Return-Path: <netdev+bounces-267893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBL1HHwLtmnv8gAAu9opvQ
	(envelope-from <netdev+bounces-267893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 02:29:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B6C28FC29
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 02:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70367301F189
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B79202F65;
	Sun, 15 Mar 2026 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btqFm27s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858643FFD
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773538169; cv=pass; b=BsPjXKt01PmMhESq8qJYyCkIHx0SBKjevHBTIQC4fhp09jv+ax4V/iOfX/mkgD07Ljnk36I+MpfhFbnzb/MIz19S+fGXDlZsy0jJBpasM1MuRLfMjeIt1ryWBkcgY8ceeV9ekKMNoeNpBC8YYAtu81WHB4qjYxy075IADcYTdP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773538169; c=relaxed/simple;
	bh=+9DjsqKn2tw/eLc6Maj+fVaa2roLgkbOUSwE8+V3Y00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5vndhfMF6l67x85Sq8OotWddqGX8Yt1MoPbDT/ZN0xMBw3Iu7av1Sf9dzHyF0ti3B8pYazSW3gBoVGw8+mmJy54QhF6/ovF6SDnPORyrru+p/qZUf+eQKEIoWh0qJkvltPcKundYSDNxcBmrwMRHFqXCkfDcakMYtZMvlfEMGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btqFm27s; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6616cb8c80cso5228478a12.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773538167; cv=none;
        d=google.com; s=arc-20240605;
        b=Tzt4/C2wpcUqqtx3Ri/gHbgqafYVj/Its/T9SVTYOaTvrQVc8Qu5wuW9m084xsU7T8
         2GXBSgm9YdVHmtZljEBGgYW92M5Xs/I94r5YTIv7Bym5DEB7EWOPUt/FlffVELZ8RcTP
         LmUJ+GCpmYNuMaFEgR+4iU4POdBYqM5+1hN7bDH0zthN3ZTk7pCboW8toIijHcqTlTrH
         0oAcyh2U3YFF1n5K1RAtr+XAOIxb8L5cLWTh3ubcUOIIOFC5Q6/9GkeNTXnYg0mVMKpp
         ELKXpl+rwcY1VNSBksceWjlJ4zBsTiXAQ6NLCRAv2N/mkO7WYhQWdwcb6YnzmASEllko
         4ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+9DjsqKn2tw/eLc6Maj+fVaa2roLgkbOUSwE8+V3Y00=;
        fh=EvasPB8aQ391EcFkKTDO4zKoDY64vLcyaCPO/dozrqk=;
        b=S99cIbR8r1XMW2rP0sLOfFzia7fFjlLLp8lwmZpvw8ClL3H483c6n0jPtMORLHSs80
         zIeUk0xWHfCHGiQmjq9rt1VYKklaGNyWYC3Ap5TTnv/OV/3btmGk3Cs/qxoUwGrljiiu
         ArD1qjyq5/RY6dB0OEg4z5YRreVd/OHkmckDwzVwjrgm7WKj7L/p9LAbYtgb82wUCrX2
         048gCIeN3mizoAL4k8RHa15Z5fnkZ3fcY9Nl4uZmIZCJCXSaWuTRKffuA54x6XN6mBnP
         iJgDKRnrg5qUIRJwyPRUlOfKRXlWUlMmvc6oU92G1ayeUZKqd7Y0ZiUMAZKrORlFzG/s
         ej/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773538167; x=1774142967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+9DjsqKn2tw/eLc6Maj+fVaa2roLgkbOUSwE8+V3Y00=;
        b=btqFm27sjcsqvEgBRN5vKRPZsm/346w9pdm+7HBXH6POzyDmpYuGdueZqO9Yz47DeD
         0hw+QiFZkqmsFwGN5XEDGTz8aF5aDDdiwX63E4pBsokhe/1p2YjcJRD5jyv7vgG1AysZ
         XtHGZrBcOxjBbhTyxvnVyx18q4YoRO44bhi52bscDcqdgTHtoLuPYkC97Z6q91aGONK9
         rP35C2zn/Ob4U9CZx6LZW6srd2rRza2SU0qiJ33GVVSb0tp0ISpj1ANw4e8EExbjuhdd
         4LeVpdcwLpmSGDX6IkZkuCvGgqT4soybXHhXL8/7hDkWhLVD/l2bnjW9TFjD409gbOY8
         EB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773538167; x=1774142967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9DjsqKn2tw/eLc6Maj+fVaa2roLgkbOUSwE8+V3Y00=;
        b=kHXCQcLcU4E20SM0R7+jyQQ9HZGFEEWvP5QZxNJLLI0cai47aeANZyVmyBS2l4jIIL
         QgmQC7YO1dLaJbmv0BpY1Vkx1SXFybnr32WHfhmghvUmRU6Vj+4VgBvrAGwUpd2qclLV
         Yl02bMEev7Juopo6j5ReaOsn1JhN7QyBl2roqCd0xnZ/p1Ov0ipe8fcRBHwq9IyU8Qce
         XmiiLnMPHmh3WhFvNaF9Hcoa2yoZ9aG0vaR6Y5BRzhi0+Ra7JNJwC5QrFpe7JBFsm6WK
         eye08dVs5gQFIekpYxYCAHO5WWSK64WSKsidqLl4PdRmHeUo6ezZ+zv56tDZoX79lvJC
         O+3g==
X-Forwarded-Encrypted: i=1; AJvYcCX0ioyzVX2JKeFlj+42hsSScScI3qHP/O7C2JuORT5ijUGXQBbvRwEgmTLHXYEdu7YXo4pofE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3f1PW7GdR/v++mIZI0gXCqZYCJMTYq2O8t1DV4pfHsfxtJVJ
	gTVdXgTa92qM1/3+OevbWxdPWo0FRMVNoiz0LihA6bTETn5O9YRwzQLUlEKwLLu3r8ksk64WJS2
	obCjLQBikJsnOiqnps3/eWU0IWKeyxks=
X-Gm-Gg: ATEYQzz3WKED4t1mpj+ZVHTQsp+gJuIv+WqVOZXnIRkEtqlW2Uq+/jeZ+pBbzEs1HzJ
	fWwYiptJNn2sWpq1dZ86udLzxAqK5H0eRI9ZCqEU7iav1DqUn5b06FxD13Lc6xLV8JJWO7NJHVb
	tA4fooETg5RZZHdOs2bHV+ufE9TZYCDnMgo3c/Ca9fu2Wn6chHgodjBY5lXd77r5566OfAAlkbP
	hQ9yZKtZgjACfs26BeJFrxznpsKFv1FfX7p61hK5z5nnSrjckN3tGoQ3Dk1Qf76nizzmX/aVbKN
	IDrZUkdUIgK3JctDUik/BZpmH3pZk2o+UchWZPrBLayWBaynF+Fs/d2R54inqVl3wdc719kazA=
	=
X-Received: by 2002:a05:6402:2110:b0:663:a321:6f98 with SMTP id
 4fb4d7f45d1cf-663babbee24mr5371944a12.19.1773538166565; Sat, 14 Mar 2026
 18:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com> <20260314130601.0ec7a534@kernel.org>
In-Reply-To: <20260314130601.0ec7a534@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Sun, 15 Mar 2026 01:29:14 +0530
X-Gm-Features: AaiRm50zmYxyM6Qp4TsIFq_HWR2boNHuFSZpLkcLZjdTo2q7GFDvDFoktscwJvw
Message-ID: <CAPrAcgMBQsVAG3utAD=7dp5tU1jjEBPO5QQGpMUrDu+rMrDJaA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/7] Introduce async callback ndo_set_rx_mode_async
To: Jakub Kicinski <kuba@kernel.org>
Cc: stfomichev@gmail.com, horms@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com, 
	mst@redhat.com, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	jacob.e.keller@intel.com, ronak.doshi@broadcom.com, pcnet32@frontier.com, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
	TAGGED_FROM(0.00)[bounces-267893-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C3B6C28FC29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 at 01:36, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Stan is actively working on this:
> https://lore.kernel.org/20260313145113.1424442-1-sdf@fomichev.me
> I feel like I spent enough time reviewing your attempts and Stan
> will not need as much maintainer attention to bring this to
> a closure so let him cook. Sorry.

Honestly, I should be thanking you for not throwing it out sooner. I
don't think I was skilled/experienced to actually make it work and
someone more qualified should handle this. On the bright side, That
means I am now much better at solving regular boring bugs and I think
that's what matters. Cheers

Thanks
I Viswanath

