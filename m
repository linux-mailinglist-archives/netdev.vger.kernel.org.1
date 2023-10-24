Return-Path: <netdev+bounces-43746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB57D4771
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE25280F35
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 06:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D92107BE;
	Tue, 24 Oct 2023 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B096111BF
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:29:25 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD6DD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:29:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A17796732D; Tue, 24 Oct 2023 08:29:20 +0200 (CEST)
Date: Tue, 24 Oct 2023 08:29:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ben Greear <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Petr Tesarik <petr@tesarici.cz>
Subject: Re: swiotlb dyn alloc WARNING splat in wireless-next.
Message-ID: <20231024062920.GA8472@lst.de>
References: <4f173dd2-324a-0240-ff8d-abf5c191be18@candelatech.com> <96efddab-7a50-4fb3-a0e1-186b9339a53a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96efddab-7a50-4fb3-a0e1-186b9339a53a@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks like we need to limit the maxium allocation size.

Peter, do you have time to look into this?


