Return-Path: <netdev+bounces-23340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5985476B9FF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3E2281A8F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0AE200DA;
	Tue,  1 Aug 2023 16:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195C4DC9B;
	Tue,  1 Aug 2023 16:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E74BC433C8;
	Tue,  1 Aug 2023 16:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690908802;
	bh=BkWqBhDYPEqAwt1g3ViRliirqnUaKD5LRWPIiBLWGmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQimNDN+S32Wcs+ioSSsu/LymACiSkIideOqRPDur3eTHop/2vD0Mgytks+WcY8Dt
	 UdUqV1AWPD6OFJspWg6kPgvEJ6MWKvsZrwB5zPAqpYTpSgzJoBBqBO7/yjsWGhHPAS
	 o7z0M+SPzipXGdMZd97uCbEK68sz208wegcbI4aRGevRoxCnMhLESGc3pte3xv0mGI
	 NK0BXAhC0x9R9drqlakeTNtKaW+uqFh7u/uJHN7DwRINECXGyoH8ItUKVA9BBq5wQT
	 cEvs5doKEWYtefs8ObDtZqu2TLvcnVuACHXa7PTpKe8JsdfkG2hM/b6I3SuESW3Qz5
	 bijvXc4Tdwfbw==
Date: Tue, 1 Aug 2023 09:53:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 loongarch@lists.linux.dev
Subject: Re: [alobakin:iavf-pp-frag 11/28] net/core/page_pool.c:582:9:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <20230801095321.3ce734c1@kernel.org>
In-Reply-To: <217dc739-05f5-a708-d358-ba331325d0cd@intel.com>
References: <202307292029.cFz0s8Hh-lkp@intel.com>
	<217dc739-05f5-a708-d358-ba331325d0cd@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 15:46:22 +0200 Alexander Lobakin wrote:
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202307292029.cFz0s8Hh-lkp@intel.com/  
> 
> Jakub, could you take a look, is this warning reasonable?

Doesn't look legit to me. I can't repro it on x86 and:

$ head .config
#
# Automatically generated file; DO NOT EDIT.
# Linux/loongarch 6.5.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="loongarch64-linux-gcc (GCC) 12.3.0"

Adding loongarch to CC, it must be arch specific ?

