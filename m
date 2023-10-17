Return-Path: <netdev+bounces-41801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E7C7CBEA9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC43B2102C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9D3E490;
	Tue, 17 Oct 2023 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIgP22qa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54827721;
	Tue, 17 Oct 2023 09:12:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED58E;
	Tue, 17 Oct 2023 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697533953; x=1729069953;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3VKz2nC7lyrDD58NgcAxec6nbzS5Bl7KW30kPUiaSaA=;
  b=GIgP22qaprhm5ej5chPCYM+mTG+x+4/+oBcODHXqaGLyPSk9G8nqbqZx
   WjSV7RrH1UvaU1yGOSQFvWzqhav59k0u8XR9OEHmsZekweegXXc/d2Z8g
   a/TXf0W5/aAJNiErf1U1lzYEr4cdUBWWsuxex7Cb7qk7HrJZD6JKEjLLm
   xuRa0qG+fLIOG5QsNl2k2qiFxsEKSZAClbOuzjdHo73pU6KnSe+R5BIOd
   ueKs4LgCwjD9KF+5/913yt7RreAqO+L9lm35XihFJxviAqKnNdSGjaPNd
   DZr8rPtZuXwvT3UX1e/zWqyc0G+FKQlyiW9Jd9nq1BSKRXZNLSQ2rnnfZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384617332"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="384617332"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826363773"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826363773"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:12:28 -0700
Date: Tue, 17 Oct 2023 12:12:26 +0300 (EEST)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ma Jun <Jun.Ma2@amd.com>
cc: amd-gfx@lists.freedesktop.org, lenb@kernel.org, johannes@sipsolutions.net, 
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com, 
    mario.limonciello@amd.com, majun@amd.com, netdev@vger.kernel.org, 
    linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    Evan Quan <quanliangl@hotmail.com>
Subject: Re: [PATCH v12 4/9] wifi: mac80211: Add support for WBRF features
In-Reply-To: <20231017025358.1773598-5-Jun.Ma2@amd.com>
Message-ID: <34acd59e-ff40-1e7-7986-b3d3832a13f@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com> <20231017025358.1773598-5-Jun.Ma2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 17 Oct 2023, Ma Jun wrote:

> From: Evan Quan <quanliangl@hotmail.com>
> 
> To support the WBRF mechanism, Wifi adapters utilized in the system must
> register the frequencies in use(or unregister those frequencies no longer

Space is missing.

-- 
 i.


