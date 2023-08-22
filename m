Return-Path: <netdev+bounces-29527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8923E783A41
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B912280D6D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596E6D1B;
	Tue, 22 Aug 2023 07:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5F1FD0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DAEC433C8;
	Tue, 22 Aug 2023 07:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692687735;
	bh=Slg9Rrck55ui9hK/Yr9pb9KndYPiVtpXtFsYx8Md7eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLv3XsTe9n70+2i29n0J4WnUnPgHaK2jLFfOfAPpCLgu/vDkIfhHXe3SooXQtnOt/
	 uNsLQT6RJCWFosyl1yAaKLFMkz5tk49b+iWlcNDP95Fv7nPMUMJUDi8gpYkoYvNSSx
	 361QcQa6zJsJrxUfcW+nv+4ncXx0oMuu5jGKw5obziOvIzY8P3lbaXTLYofwtW1zE1
	 PuW9BDwWRrLv+u2/C3O/LmdJUhU8nQHbkkG2jbCznrj5eJsdEPbKD1GbU6R5Z91108
	 eiyXnWcq5IeTG7jK/u6aWjHb5oyOUUMsugfM64DwVq/12sRletmzE1a+DeMmJ3bYpG
	 h/5qmsoh8s5WQ==
Date: Tue, 22 Aug 2023 09:02:11 +0200
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 iwl-next 1/9] ice: use ice_pf_src_tmr_owned where
 available
Message-ID: <20230822070211.GH2711035@kernel.org>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
 <20230819115249.GP22185@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230819115249.GP22185@unreal>

On Sat, Aug 19, 2023 at 02:52:49PM +0300, Leon Romanovsky wrote:
> On Thu, Aug 17, 2023 at 04:17:38PM +0200, Karol Kolacinski wrote:
> > The ice_pf_src_tmr_owned() macro exists to check the function capability
> > bit indicating if the current function owns the PTP hardware clock.
> 
> This is first patch in the series, but I can't find mentioned macro.
> My net-next is based on 5b0a1414e0b0 ("Merge branch 'smc-features'")
> ➜  kernel git:(net-next) git grep ice_pf_src_tmr_owned
> shows nothing.
> 
> On which branch is it based?

Hi Leon,

My assumption is that it is based on the dev-queue branch of
https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git

