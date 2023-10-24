Return-Path: <netdev+bounces-43957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A372B7D5954
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B227281941
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0498A3993D;
	Tue, 24 Oct 2023 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="Hde902/X"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA014AAA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 17:04:25 +0000 (UTC)
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 10:04:24 PDT
Received: from mx.nohats.ca (mx.nohats.ca [IPv6:2a03:6000:1004:1::85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE1118
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:04:23 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4SFJ9h0RpCz3DQ;
	Tue, 24 Oct 2023 18:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1698166584;
	bh=nbgb0QENjORTNJyxyR7mGM2JrUt0lGqX2OveEgwNeVY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Hde902/XKnFbwTcBLea42aHAY9+cUM1vMzhM9cxNFDCkAfJVtYaoRBwbadd2zPuS3
	 hP6qdlZGMYiZPsHvhzuWknkYG33QCwHy9/XTEDOoneTTpTlh2BU1S4eCLc8z4SCbXI
	 D4CrxB+mdDoL+FIRfXIdAs90s1kxJu6+dcD8qs/U=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id Vz7hKpAlXuLV; Tue, 24 Oct 2023 18:56:23 +0200 (CEST)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Tue, 24 Oct 2023 18:56:23 +0200 (CEST)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id 0B08D109FC00; Tue, 24 Oct 2023 12:56:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id 05F9F109FBFF;
	Tue, 24 Oct 2023 12:56:22 -0400 (EDT)
Date: Tue, 24 Oct 2023 12:56:21 -0400 (EDT)
From: Paul Wouters <paul@nohats.ca>
To: antony.antony@secunet.com
cc: Steffen Klassert <steffen.klassert@secunet.com>, 
    Florian Westphal <fw@strlen.de>, 
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
    Andreas Gruenbacher <agruenba@redhat.com>, devel@linux-ipsec.org, 
    netdev@vger.kernel.org
Subject: Re: [devel-ipsec] [RFC PATCH ipsec-next] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
In-Reply-To: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
Message-ID: <060b50b6-d5f0-1698-8adb-cf53b2b8a5e7@nohats.ca>
References: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 24 Oct 2023, Antony Antony via Devel wrote:

> The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
> in 2004 [2], has remained inactive and obsolete for an extended period.

Thanks for doing this. I can confirm libreswan does not support this
anymore as of October 14, 2020 but in reality hasn't supported this
since KLIPS was obsoleted, which was before the first libreswan release
in 2013. On RHEL/fedora this was never supported.

Paul

