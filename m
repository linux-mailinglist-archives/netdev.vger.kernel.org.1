Return-Path: <netdev+bounces-161414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9B4A213FF
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 23:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6EF3A6CE0
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E01946BC;
	Tue, 28 Jan 2025 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0+ZmWNk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1788136988
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102421; cv=none; b=XquVC9I9/gLi7lomKjzdula04agkeB/XHVitJwlUqk99+fHlepxOiYaS8WuhlNT1RPYpqy5WOUv8b0IDrhcklaMw8e0KyuAMwGQvQ/O990vkBT6OyGOna5NdJEFyBHoQWTHLwBqXBN7IusplYPvhqnwWqPSPok3jD+RLmlNZQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102421; c=relaxed/simple;
	bh=RqW8MtpaEcxbWHTJddZE7Gcl1SJ/I2iTrm58WfDfj7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8LPw3NPPbJFa6nIb9kypCJaBR7k4hr7ID/hjpqwp0N6i8BNisVzyHArRbfshbpndrycHF1iJVB5iZpDFpqJHMtCKDPwO29O6ciDTOu9nV63oqlPFdYQiFNqxNTHtwmbXWzL8U0kKkAEEyhkCiFUKA+ujQI97+edXCVa69Nl2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0+ZmWNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEBEC4CED3;
	Tue, 28 Jan 2025 22:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738102421;
	bh=RqW8MtpaEcxbWHTJddZE7Gcl1SJ/I2iTrm58WfDfj7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q0+ZmWNkzfQ3yEeGs8tA2ZgJrTYEzAKpW/ZfxnePU9MfuAoKo4M2L2nsJwbEDsMpo
	 YgsvKhUw+KpkuedJI2n0+659/nslhIUXSZfixvezMOIb/QO7h6c11yol7s+gJV182u
	 XPeBatOrcloG1hy3foAgNc2/uTyrNS08QcixUQ3tnEjMjeNpLlV0y1LaB9yewcTCBW
	 APBG3aynjFaWRoU9Zp3n8jLNqrT2xRHE9+z9j5+WFkbyWDrkbaavLfIquog81UwyBi
	 Kh+zI6shftDpTW6BmW1+NjG95jKYmj62Z8ktdG+mrk4A98JwXLUyRJAOatG/K1fZ7o
	 fcHKpk7Oinw5g==
Date: Tue, 28 Jan 2025 14:13:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
 <mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
 <amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Message-ID: <20250128141339.40ba2ae2@kernel.org>
In-Reply-To: <DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-10-danieller@nvidia.com>
	<20250127121606.0c9ace12@kernel.org>
	<DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 13:23:42 +0000 Danielle Ratson wrote:
> > On Sun, 26 Jan 2025 13:56:30 +0200 Danielle Ratson wrote:  
> > > +		open_json_object("extended_identifier");
> > > +		print_int(PRINT_JSON, "value", "0x%02x",
> > > +			  map->page_00h[SFF8636_EXT_ID_OFFSET]);  
> > 
> > Hm, why hex here?
> > Priority for JSON output is to make it easy to handle in code, rather than easy
> > to read. Hex strings need extra manual decoding, no?  
> 
> I kept the same convention as in the regular output.
> And as agreed in Daniel's design those hex fields remain hex fields
> and are followed by a description field.
> 
> Do you think otherwise?  

I have a weak preference to never use hex strings.
I have regretted using hex strings in JSON multiple times but haven't
regretted using plain integers, yet.

