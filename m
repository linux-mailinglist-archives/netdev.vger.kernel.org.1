Return-Path: <netdev+bounces-161661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C473A231B6
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CC11888CE8
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9281EE7D6;
	Thu, 30 Jan 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmj2fQC+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB31EE7D5
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254277; cv=none; b=OqIbNh6wBL0BlDQL/t0TEoec65hkzggKzDHBHmzrdd2XbddVXX+BXZs8eSpvpuQwFv/5sL9FTWlMoqB4wrtQMLfA2uuvsq8xprbYqmjxPgeOqMpYAYMye32Rmy1KjuU0DkKb3T6/fJubKG1y+9N4P0J1Le+xmVfW0jah++kacPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254277; c=relaxed/simple;
	bh=45G5j6oyDGlW8Bf+qvtfsv9vieDtBKtUR0HB4BhRBxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poFNTt9mvizB+29zgiD2FzlMoComMR1/EdkvQqrb5+89+mMrEe2CY2wzTlhKpralx3Pu7904lVKIYipFL7FsO9iPy6Xbx3X6vr5CyllIiEJ5Ng+WAi3zk/nzifkNLWJvuTYwGcGidXs4tF/go+a71q7MQ38HHcTVzpE9FmwCPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmj2fQC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C653C4CEE0;
	Thu, 30 Jan 2025 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738254276;
	bh=45G5j6oyDGlW8Bf+qvtfsv9vieDtBKtUR0HB4BhRBxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kmj2fQC+EwmNzC2b9w9McoY8oggeppih+eTnUesUqMuGnZpHWqxpLz8F/4mZXW7do
	 w6Yi2UsOodKZaQdOg8fzNgBeqQqdYhR6QFIWQWlAJDfgPdL3s1HrR0hhP/HUbtMA0d
	 5n+6iLqphfRnStoe6jR9AeL78YyEnxh6n/0asomXW3I/sfeRHUTBsf3yZ6g89buyX7
	 VoKuCM0FiBjEWtC3FW6AjRajRmUKyNnhfeBEBHn05DwXuq1f/mD3qKDPmdvwm8cVaO
	 ocWk32HA3bzHdanNtgEU4DDpF2PgqLBBaEYEoA2ktf6vHiJMcHGK6LaJ9RRXQTiv9U
	 EILA0Jlau9Cyw==
Date: Thu, 30 Jan 2025 08:24:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
 <mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
 <amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Message-ID: <20250130082435.0a3a7922@kernel.org>
In-Reply-To: <DM6PR12MB451613256BB4FB8227F3D971D8E92@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
	<20250127121258.63f79e53@kernel.org>
	<DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20250128140923.144412cf@kernel.org>
	<DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20250129171728.1ad90a87@kernel.org>
	<DM6PR12MB451613256BB4FB8227F3D971D8E92@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 12:38:56 +0000 Danielle Ratson wrote:
> > > Yes, the unit is implied by the key is hardcoded. Same as for the
> > > regular output, it should give the costumer idea about the scale.
> > > There are also temperature fields that could be either F or C degrees.
> > > So overall , the units fields should align all the fields that implies
> > > some sort of scale.  
> > 
> > Some sort of a schema would be a better place to document the unit of the
> > fields, IMO.  
> 
> So should the units fields be removed entirely?  And only be
> documented in the json schema file?

Yes, more than happy to hear from others but a schema file would
be my first choice. Short of that as long as the unit is the same
as in the plain text output there should also not be any ambiguity.

