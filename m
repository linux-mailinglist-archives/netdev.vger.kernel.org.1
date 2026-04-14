Return-Path: <netdev+bounces-278493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aYifI11Z3mmLCAAAu9opvQ
	(envelope-from <netdev+bounces-278493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:12:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE323FB940
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63328301A154
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40A27380A;
	Tue, 14 Apr 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LOR05mK+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E123E92A1
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179489; cv=none; b=TNGcQ14SWytcyIFDQ0EeFjGIUrHrbzYCtzGh7jKSwoeJHnpzKyzUPAzH+ncdLXpZea+VRFTITIqI7GMn+BrYBux7r8JxjtRfajzxuLXLahiBqw5WwKl4uTuiBjT4WEBzeeSYKUSRpw7LrNP3/BcsyO09YD2xX/KVLR2Z1fADLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179489; c=relaxed/simple;
	bh=wtmKouu1J13QOKEWpC/Rhgp+PUitDlJyO7jIdqkEIVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsTfZhP5UNsnsSLpRj6TpzYZmvy5ZE5lyn5Y5w4HFZdFGxfM591T9NU0kFJ+FYjn99J4nlOG3Ts1PX5AfNBHNA2HOVpDzUgMa7GQF017CvO7NltKBMTV2mwwtnAUxSmsSck2dJ6xVqviwI3LCTeU2B76MvFZtnzSSEfmcMrAGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LOR05mK+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acb550db18so19085076d6.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776179487; x=1776784287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYWxsN8NcBk0hkmTwyrJ9dFetqgCC/fPQOeOuZaqCQI=;
        b=LOR05mK+HpHUZy18w4Dk7mDIMTVt2CqGJv6K1mBA55KO1uywBz8h8IBKBzhn4aHAO9
         vH0NS+fuTcuiKi0VoxchkLiUtLN6rj7dqxajvrCuQyW0IdXx5NElXiYa4YWn5DDd/BtR
         WFgWMEErubR+eerVtOWit7waU1BfplQlQbeI0ukBBX1Hfp8klPZxXlCJOs/B4824tYD6
         vOMiryVGnE37XdbdYE5g3wxBwhLNymPEJbmA6ALYM/d6B+I5HUMss6Fc9WF0N1a3VH7u
         OcXMJI2BDU4/8aMgg7lU7yp0PYDLaJwX/fP8wrU46jXXqbpXimJy41RSnyg/4SlBtXPv
         9LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179487; x=1776784287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYWxsN8NcBk0hkmTwyrJ9dFetqgCC/fPQOeOuZaqCQI=;
        b=UVix86njmC4wUvhpLHdaU3l0aR+TS/LNlGCltZHaA280Mqy6gzC4mCO3l9dvNA1XTb
         DScHO/jyelPXawbUIcImmeZ1iSE55i9EjJ7vA5PdI3I+yRhRsvsbBySAo7aiuXors05J
         jjcDrIJZK7aNbFqf1r835d6ISncxSplGiiy7cK9v9TjNulCkdLgmZf3ziHi/Xa3vS77L
         ovTx1yxKR/BfJ6OF036RPFRW0UiMSkfK2ue2aWwYtPdfKPRe9fmgNSITQKZnvqHuX11u
         SfeoZE4mpriR/uhy/eSjQnQoj5KA/O9TlnRuOExpiJOM1onB2UAJDutVAPmOBaQ1Ivmn
         pV/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LHjF4Ucl3Rzypau/O2esFGX06fgfRpPkApeWaalgNXkFkoagfcnOmdTpZYPebX8BfA0jqTYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvwDuARCUfex6yC/p/zLhsQhXRo2zV0GgktqhDiDOhus1JX4O7
	Kj7RUsJrVfjK07304WyIXERdnBliEd5tz9N/ukkjh5EDXKC4OdUDqNTwAoO099MA/Yg=
X-Gm-Gg: AeBDiev+x6Lla2z14Bd8JylJbz7KUrafdpMsxdt4e5K2e0kIwDwbN4RWybmzrMnETWe
	LnW0yvJPdTmcbzHqD4DvRhcdAcqPdRTuQA9dWg9CkigcDtHc4ZS9WuD58VWkIBT37Z/2LfDwIWw
	9GULXylqnEC1LnjW5MNykONbInrnV9jWzWvDhcd8VRu6HQ7In2XwfANK+DAUYEBfkDCN/AedoFU
	2in3crDOVoAt8oFsAah8Bf8qJnLhXtmD7LRaKFsRcQh9DBtoXhy92/aeRdSO6Np0BsRVhkQRrd0
	ta3pYJWJSRRK45D0h3gTgQTioQZ3L/NPWXgkIVopejDndKauc8lUele84sQ4paIhOy9RbqqRtqA
	8ZF6bht+ZaLBE5Tds9MyKzgLGJoXd3CyWYIODvX65x336UBM6lAVMgJskWkMSaLpwKMwpPrF+MU
	8zZ8RBj11pxnHBs0fJauNKa27FDQCuFUz9Gu36J7eapvxaWz/BlHsBLLH1AsoT0TPPNK3PKpTeQ
	bcLFg==
X-Received: by 2002:a05:6214:4a01:b0:89c:8709:d238 with SMTP id 6a1803df08f44-8ac862b51e2mr284214856d6.40.1776179487026;
        Tue, 14 Apr 2026 08:11:27 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e35afsm159006516d6.3.2026.04.14.08.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:11:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCfQD-0000000BNfx-2aVf;
	Tue, 14 Apr 2026 12:11:25 -0300
Date: Tue, 14 Apr 2026 12:11:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhiping Zhang <zhipingz@meta.com>
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260414151125.GF2577880@ziepe.ca>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413100152.GG21470@unreal>
 <c3a6c6ca-3b71-476c-947a-5f2393d046bd@huawei.com>
 <20260413191930.GP21470@unreal>
 <b95ced54-339f-4859-b3eb-8bf261393ffc@huawei.com>
 <20260414085723.GR21470@unreal>
 <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
 <20260414103547.GA361495@unreal>
 <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-278493-lists,netdev=lfdr.de];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[104.64.211.4:from];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[104.64.211.4:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DWL_DNSWL_BLOCKED(0.00)[ziepe.ca:dkim];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[104.64.211.4:from,47.54.130.67:received,100.90.174.1:received,209.85.219.42:received];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	RECEIVED_SPAMHAUS_PBL(0.00)[47.54.130.67:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EE323FB940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 10:46:00PM +0800, fengchengwen wrote:
>    We have a real platform requirement:
> 
>      * 1. Devices in TPH Device-Specific Mode with no standard ST table
>      * 2. Steering Tags must be obtained from ACPI _DSM (kernel-only)
>      * 3. Devices are fully managed by userspace drivers (VFIO/UIO)
>      * 4. Userspace must program STs into vendor-specific registers

No, this is nonsenscial too.

If you want to control the steering tags for MMIO BAR memory exposed
by VFIO then the DMABUF mechanism Keith & co has been working on is
the correct approach.

If the VFIO user needs to control steering tags for the device it is
directly controling then it must do that through VFIO ioctls.

Nobody messes around with other devices under the covers of the
operating kernel driver. Stop proposing that.

Jason

