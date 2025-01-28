Return-Path: <netdev+bounces-161413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95821A213F9
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 23:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20613A7732
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 22:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61A1DF741;
	Tue, 28 Jan 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVVPao4D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CF1DE884
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102165; cv=none; b=geo5VXK7f+aXdg4nayVUm+iS/0lGlrvqVqKgLyj2mpNOJVddd1YG2+LciAnVwZLzmNMtXUEet5E2vmYDWa1g+Bb72dg0zBm92s3rij/4euxmubzg4RN3NKWUSF+3IWFm9tdD9USB4TUEH16l+jsmzd9sI09xliQGyAPAu+LN7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102165; c=relaxed/simple;
	bh=9tlvILY3bxAtK2NNNpiqDywhWoGbGx4Ar+np1D29ykI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQoufX7ojy5QEseSSp98SwD/vTAEOOFimILIrprjMVsiMO1CxsXnhzno2Vw+qNJE9iRqomT47SkdRWTCaK4WhzbX1vD31NOWZLLSak2uKqPYG+lDQulzeq3sNVT8dkl7LNXbrBczZCBxinM2vq39du05U3+bzKTqm7mlf77WzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVVPao4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C0AC4CED3;
	Tue, 28 Jan 2025 22:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738102164;
	bh=9tlvILY3bxAtK2NNNpiqDywhWoGbGx4Ar+np1D29ykI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BVVPao4DWtUWu48u/Kq7acJ492ygjOyM8ufpU0EAoz6LrPaXvz4cFvoqSbtyT6jNa
	 5XJbCe+0WPnc/Ga/KRpSbRXbxeRqWWRWQVIH73g/IpOMf6QxVYVjPeqZYtDV2/aXwy
	 OWRdz4bSTIVypvsgU2OoJmyyBpvTKE0sl3ZpAgq+1aMVrLANs8HT+y0OJeLwngmQuF
	 7L6AkQaGOR/4Jz+8wFBYM/jylHfPS+wKKocnaL2EJ49MvyG2ETX6p6UxeA3nERytcV
	 DUD8qyo3WtrYUfmR5uzZikjGL4yw/je48Fpuj0e/hzRjzfLVxFvWWQR9hqx8SxMvb9
	 bShxt0Jnxt6qQ==
Date: Tue, 28 Jan 2025 14:09:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
 <mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
 <amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Message-ID: <20250128140923.144412cf@kernel.org>
In-Reply-To: <DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
	<20250127121258.63f79e53@kernel.org>
	<DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 13:18:54 +0000 Danielle Ratson wrote:
> > >         "module_state": 3,
> > >         "module_state_description": "ModuleReady",
> > >         "low_pwr_allow_request_hw": false,
> > >         "low_pwr_request_sw": false,
> > >         "module_temperature": 36.8203,
> > >         "module_temperature_units": "degrees C",
> > >         "module_voltage": 3.3385,
> > >         "module_voltage_units": "V",
> > >         "laser_tx_bias_current": [
> > > 0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000 ],
> > >         "laser_tx_bias_current_units": "mA",  
> > 
> > How do you think about the units?
> > If they may differ module to module - should we aim to normalize those?  
> 
> Not sure if I understand what you mean. What do you wish to normalize and how?

I don't understand the "_units" keys, basically:

        "max_power": 10.0000,
        "max_power_units": "W",     <<
	[...]
            "low_warning_threshold": 0.1585,
            "units": "mW"           <<

or:

        "length_(smf)": 0.0000,
        "length_(smf)_units": "km",  <<
        "length_(om5)": 0,
        "length_(om5)_units": "m",   <<

What are these for?

Is the consumer of the JSON output supposed to be parsing the units 
and making sure to scale the values every time it reads (e.g. divide 
by 1000 if it wants W but unit is mW)?

Or the unit is fully implied by the key, and can't change? IOW the unit
is only listed so that the human writing the consumer can figure out
the unit and then hardcode it?

