Return-Path: <netdev+bounces-39785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F37C47A4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9A41C20C59
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF735512;
	Wed, 11 Oct 2023 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8OUDvpt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06827819
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DEDC433C7;
	Wed, 11 Oct 2023 02:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696990360;
	bh=Os7aVwc+0IsMf4xXnSssPooy7R8RPE0s+8vnTgx5OI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8OUDvpt1xbEH+F6yfo7D2J899ofuqk6YGX27dH+rkhdtETTyBwvmHB9PLvTlfEGu
	 nzJ2ZDU0u4jY30thG5h7xEvxqbOjvKCo+7Y3BDu8qZzgf2nawBFhrHsgMumgvb/J7B
	 3g9eq1RCdfx+kb7wXqU+5h3xEJsWnkgzzMe+XK1nbKfdae8JcBDl8M1bXihz8c/jgm
	 TRD/QVGK0IQY4iBLQeKeYBEneXoeHFKD/Y42bcfBq4TVb/KDMxhBc8W8I8HapOMmYs
	 UcQ3oWEhW5J0o0mYWMrfvAS/Kd2o8xgl3qaR3lcsJ9gPBiBqF6z4xRz5JX7kHbHBGi
	 MSbF8DiYzBFPw==
Date: Tue, 10 Oct 2023 19:12:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v4 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <20231010191239.0a8205d1@kernel.org>
In-Reply-To: <169658368330.3683.15290860406267268970.stgit@anambiarhost.jf.intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
	<169658368330.3683.15290860406267268970.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Oct 2023 02:14:43 -0700 Amritha Nambiar wrote:
> Add support in netlink spec(netdev.yaml) for queue information.
> Add code generated from the spec.
> 
> Note: The "queue-type" attribute currently takes values 0 and 1
> for rx and tx queue type respectively. I haven't figured out the
> ynl library changes to support string user input ("rx" and "tx")
> to enum value conversion in the generated C code.

Let's leave the maxrate out of this version entirely, please.
Otherwise looks good.

