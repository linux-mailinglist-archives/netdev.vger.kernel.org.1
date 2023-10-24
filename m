Return-Path: <netdev+bounces-43962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07E7D59CB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590681C20A9C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FCF3AC28;
	Tue, 24 Oct 2023 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="suczj/dx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAA2420F
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 17:31:56 +0000 (UTC)
Received: from mx.nohats.ca (mx.nohats.ca [IPv6:2a03:6000:1004:1::85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EE610C6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:31:54 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4SFJyd5twpz3DF;
	Tue, 24 Oct 2023 19:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1698168713;
	bh=ZvprvHGu/w/Qj5jOdQBRJgMZeWcirXHd1u5Si2/nJ0E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=suczj/dxqaNGSPks0MWO/5M2SjEsbeDKVmIEJ4FrHKaF19FIwSGkWLUGC2nKDaeg+
	 akkWZgSyZQVkMaYkplEbcJ009pNEtVJsGptRnE4ro4sHDU2YF17X9r9/+Aji2cC98i
	 nGYHK8gMqfrK2DgixGttqD165tSq3M0CAXxops+g=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id h6cA923GhxH0; Tue, 24 Oct 2023 19:31:52 +0200 (CEST)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Tue, 24 Oct 2023 19:31:52 +0200 (CEST)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id 9A0D3109FC24; Tue, 24 Oct 2023 13:31:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id 9695A109FC23;
	Tue, 24 Oct 2023 13:31:51 -0400 (EDT)
Date: Tue, 24 Oct 2023 13:31:51 -0400 (EDT)
From: Paul Wouters <paul@nohats.ca>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: antony.antony@secunet.com, devel@linux-ipsec.org, 
    Andreas Gruenbacher <agruenba@redhat.com>, netdev@vger.kernel.org
Subject: Re: [devel-ipsec] [RFC PATCH ipsec-next] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
In-Reply-To: <CAF=yD-LUgdkZpNW9W2RV0f4PqYOkOCTRWGi6A7B7LZ1Q9bkM4Q@mail.gmail.com>
Message-ID: <270203ee-e1a8-7dfa-5ac2-d8b0ee392ff0@nohats.ca>
References: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com> <CAF=yD-LUgdkZpNW9W2RV0f4PqYOkOCTRWGi6A7B7LZ1Q9bkM4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 24 Oct 2023, Willem de Bruijn via Devel wrote:

> I don't know how important this is, but a quick online search brought
> up one package: https://github.com/rdratlos/racoon-ipsec-tools.git
>
> Behind #if defined(ENABLE_NATT_00) || defined(ENABLE_NATT_01), so
> probably there unused too.

Also: https://ipsec-tools.sourceforge.net/

 	Important Note
 	The development of ipsec-tools has been ABANDONED.

 	ipsec-tools has security issues, and you should not use it. Please
 	switch to a secure alternative!

There are known unfixed CVEs in that codebase.

While Apple and Android have their own clones of this code for IKEv1,
even basically all 20+ year old IKEv1 clients support the draft 02/03/05
versions that obsoletes the 00/01 draft code.

Paul

