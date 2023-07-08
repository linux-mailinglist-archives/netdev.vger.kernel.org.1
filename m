Return-Path: <netdev+bounces-16227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B452A74BF42
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 23:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED2628119E
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9BBE71;
	Sat,  8 Jul 2023 21:20:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F5185C
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 21:20:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22FE194
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aWfyECG0B6IYTRk2ZuBFy7NHPlK2Z6bXXu+RbWBfy6E=; b=YpjQ0/VDrhbvog8wI7Ta1fLPcA
	sZbaHCyN5j3+W7fskGrSPwcbqPNdJMeBbvy+RANUaQntvlM+6a/e2Lxe7D9EO591UZZdosL+wzcHe
	Zn9xg78PlOctYNV/divC1l4iVdD93Ap9K30O3aOpmwivd1jrrd/P1d/nuUCdL//GaEOA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIFLj-000pjp-Go; Sat, 08 Jul 2023 23:20:15 +0200
Date: Sat, 8 Jul 2023 23:20:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
	shailend@google.com, haiyue.wang@intel.com, kuba@kernel.org,
	awogbemila@google.com, davem@davemloft.net, pabeni@redhat.com,
	yangchun@google.com, edumazet@google.com, sagis@google.com,
	willemb@google.com, lrizzo@google.com, michal.kubiak@intel.com,
	csully@google.com
Subject: Re: [PATCH net v2] gve: unify driver name usage
Message-ID: <21bebfcd-8289-4512-a8d4-3fda56cf3a6a@lunn.ch>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
 <20230708031451.461738-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708031451.461738-1-junfeng.guo@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 08, 2023 at 11:14:51AM +0800, Junfeng Guo wrote:
> Current codebase contained the usage of two different names for this
> driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
> to use, especially when trying to bind or unbind the driver manually.
> The corresponding kernel module is registered with the name of `gve`.
> It's more reasonable to align the name of the driver with the module.
> 
> Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engine Virtual NIC")

You are posting this for net, and have a fixes tag. Please take a look at:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Do you think it fulfils those rules?

   Andrew

