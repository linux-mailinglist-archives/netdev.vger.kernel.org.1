Return-Path: <netdev+bounces-37992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7047B83CC
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DB5FA28158D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1D1B26B;
	Wed,  4 Oct 2023 15:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E213AE9;
	Wed,  4 Oct 2023 15:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B18FC433C7;
	Wed,  4 Oct 2023 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696434012;
	bh=W9nN7QRuZVUT7tpRXvZ9PJAQeaIUegBNlFb+DkivbT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lGAY65533YzFiIQlo1Kaur5TW8121s9xQ+sEAsBEhsDF5rfuL6VUBmtOeQn46xzap
	 IZOB4FAtvmIxfaRNsGxczGeF38nUCCKdMFGJIoj5nBUf2Dzov8ceRkKr1IPKawnWqP
	 eKe05FXP6uEZhY+XJVXSwdWyRdNRCc35HmXyye8PgJspR8hlkW1yFgLgSejD4O3fhN
	 3OV0wQQRSId34PQCvU9jvXWdzFMRKP5Br/AAZz2MyPgMiCQ2z6ricnZp52BM5nHQAU
	 0GSKvUseb7yDzUEa4sbCXOQ4RdcV/2p5dFcf11PjLEAC3jfUyS1bXceUmLjPy5dj1Z
	 BDBfjBnrA/9GQ==
Date: Wed, 4 Oct 2023 08:40:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 <netdev@vger.kernel.org>
Subject: Re: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20231004084011.7aeef442@kernel.org>
In-Reply-To: <202309201456.84c19e27-oliver.sang@intel.com>
References: <202309201456.84c19e27-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Sep 2023 14:51:32 +0800 kernel test robot wrote:
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> 
> commit: 2aa1f7a1f47ce8dac7593af605aaa859b3cf3bb1 ("connector/cn_proc: Add filtering to fix some bugs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Anjali, have you had the chance to look into this?

