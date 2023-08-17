Return-Path: <netdev+bounces-28287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6199077EE7F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11753281BF0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF9381;
	Thu, 17 Aug 2023 01:00:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8099379
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 01:00:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A19811F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A6PqXQPKNCab21F83uHC2c2WRfIWO9pCVwKo10L2oU0=; b=wTGUnOrwid3VLaDlwxSbq0letR
	/1fZ3O7HsHtZp6nl8IW6gAXKbVfUQlT4PsOqK7ajNPQbR0d8SQQDRVa0nf610KdUa9c9dCWVaXvNa
	Ni0GbmDX3p9KF7uD6WOFEPcfHR8PmNcLPbPKz79jaF1WHTOhXLZegusD1PKwYThi1TzM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWRNU-004Kfa-5o; Thu, 17 Aug 2023 03:00:44 +0200
Date: Thu, 17 Aug 2023 03:00:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next 2/7] ice: Refactor finding advertised link speed
Message-ID: <240678ed-221f-4893-a410-140c9f4f4674@lunn.ch>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
 <20230816235719.1120726-3-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816235719.1120726-3-paul.greenwalt@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 04:57:14PM -0700, Paul Greenwalt wrote:
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
> 
> Refactor ice_get_link_ksettings by using lightweight static link mode
> maps, populated at module init. This is an efficient solution introduced
> in commit 1d4e4ecccb11 ("qede: populate supported link modes maps on
> module init") for qede driver

Could this actually be partially shared with that driver? Some are
identical. Maybe a generic implementation in net/ethtool/ ?

	   Andrew

