Return-Path: <netdev+bounces-73454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7438A85CA93
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB7C283CD4
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC06152E00;
	Tue, 20 Feb 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvSGIjzZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C4267C72
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467431; cv=none; b=lG2BpFaMpCeTjxL158sczS+G30NTmqtG/tG0KokT6Ea+OLIZvUdGrH087ea2wuTrgOXEpMATxCCYdVfaVTfXA9jVnwWqHVLkq1g2YiLCLXO7emg5rxVbunlhiq1HRYp65531idotG7Z0kkgiR7ckbqxgnk9axpI7bcVnIvwEzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467431; c=relaxed/simple;
	bh=OtxqjEv157OVsJ2HHC+FKnckczQSg81r2sKtN2rORrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgHTjvdoNZe/MLzhkvcSxsv9CLBRYv0P6dyRWWNZ8PCc/WJaFXgzcUMyYdSP5lfd1LSynxGipYpZIFM50kXi8Z854jpJtiwDZ1px4iZnGQwA6Vthcj9TgBQjx13M3dFKFehM4WFUNflaj+31kmYaFL+v8Kpf7q974l9IjDoIK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvSGIjzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28558C433C7;
	Tue, 20 Feb 2024 22:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708467430;
	bh=OtxqjEv157OVsJ2HHC+FKnckczQSg81r2sKtN2rORrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvSGIjzZ8tcqthjLPuyFYhWP+zBWA+vZzTCenqXEjpt24Ny1HV+I3KCfapvHWQ51A
	 uwKLPjkbG0C724D6Vzs31uM0liQKTPa+D2zOyFY1ea8p4PEogOH14cqSJdJsy3nQRB
	 vHKhAkF1iZK0AqCs65G7C5ONNuTb+E6vOsD9K2Uyppa0bU8wMncH+gaTSP+ALe9mQV
	 eFyYmDblNYQh1YVM9L2bf3XS3ux/gS9R878cp0DAzPyVUeUiF8o+gcRIQIN1/dYgB4
	 dj6rLNT7m9AakyoUdaptcHvdWDHUHSSZ17X3LO6PF4hXhM7sJ9q5LLqwL4djfP5zWu
	 SUabgGHPKZdFA==
Date: Tue, 20 Feb 2024 14:17:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com, "aleksander.lobakin@intel.com"
 <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240220141709.42a9c640@kernel.org>
In-Reply-To: <ZdMaCfWRf9qpDSGR@nanopsycho>
References: <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
	<20240131151726.1ddb9bc9@kernel.org>
	<Zbtu5alCZ-Exr2WU@nanopsycho>
	<20240201200041.241fd4c1@kernel.org>
	<Zbyd8Fbj8_WHP4WI@nanopsycho>
	<20240208172633.010b1c3f@kernel.org>
	<Zc4Pa4QWGQegN4mI@nanopsycho>
	<20240215175836.7d1a19e6@kernel.org>
	<Zc8XjcRLOH3TXHED@nanopsycho>
	<20240216184332.7b7fdba5@kernel.org>
	<ZdMaCfWRf9qpDSGR@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 10:06:17 +0100 Jiri Pirko wrote:
> >Gluing to the device is easier, IIUC, once the pool is create we can
> >give it whatever attributes we want. devlink ID, bus/device, netdev,
> >IOMMU domain, anything.  
> 
> I'm confused. Above (***) you say that the shared pool is created upon
> first netdev creation. Now you indicate the user creates it and then
> "binds" it to some object (like devlink).
> 
> So, do you think there should be 2 types of pools:
> 1) implicit upon netdev creation
> 2) explicit defined by the user?

Implicitly, "once the pool is create[d]" does not say that user created
the pool. The flow would be more like:
 - user changes configuration "rules"
 - if device is running && config changed:
   - core instantiates the new pools
   - core issues "reset" request to the device to rebuild queues
   - core shuts down old pools

