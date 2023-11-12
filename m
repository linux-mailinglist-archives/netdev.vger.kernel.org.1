Return-Path: <netdev+bounces-47243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA787E924F
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 20:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60BC280A73
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF3171B7;
	Sun, 12 Nov 2023 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="q8IACGyb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3DC171B5
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 19:45:36 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45843213A
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 11:45:35 -0800 (PST)
X-KPN-MessageId: 01680bb9-8194-11ee-a148-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 01680bb9-8194-11ee-a148-005056abad63;
	Sun, 12 Nov 2023 20:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=2KatDo+tGEiv5HygPZcr8MfAEKAxdeUbKLbJYDgvwlU=;
	b=q8IACGybPW110t4Brr9ViB21bTkDj09WrWyilwA3kzO2hHC1nW9tQDAMfs2nNDi+dDKJ6bYQZ8BtP
	 y0VPA9Bnbo8DepfjUkpGhIOglSk/9NkU+hflT3rs47ooljhYTO4rb9Q/Vp2YuAfogaaTZ6zguEglun
	 1VFZAFehVyg9yuDQ=
X-KPN-MID: 33|iBIO2WW0WbuXCtkmmEkI3tslDfOumEWlaCtJM6zyEScoRZQgmUEBNuj6TWlS2bH
 hR0JQcS73ZJJlPibFdXDZ2yId1EwhLrGmA3VCWKS0Oaw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|HN0pn9TqsbZRanxvfUQHkWijYbSsigmMwSS1nPZyQXMPMQZ1ORNBy6qriwX873e
 cnVVhgE1K+j12m56lgQC5Kg==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0a611bd9-8194-11ee-8249-005056ab1411;
	Sun, 12 Nov 2023 20:45:33 +0100 (CET)
Date: Sun, 12 Nov 2023 20:45:32 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next] Add IP-TFS mode to xfrm
Message-ID: <ZVErXNOWfR24hkwx@Antony2201.local>
References: <20231110113719.3055788-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110113719.3055788-1-chopps@chopps.org>

On Fri, Nov 10, 2023 at 06:37:11AM -0500, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
> Link: https://www.rfc-editor.org/rfc/rfc9347.txt

It would great to have details which parts of the RFC is supported in this 
patch series.

Such as : Non-Congestion-Controlled ...

> In order to allow loading this fucntionality as a module a set of callbacks
> xfrm_mode_cbs has been added to xfrm as well.
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

