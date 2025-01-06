Return-Path: <netdev+bounces-155584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A123A031A6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F618871E3
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242731E0081;
	Mon,  6 Jan 2025 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLagySuD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14081DFE2F
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196812; cv=none; b=Gz0+UikF3QOVdwexJhUG+SEsITqT4nLrP+kw6OW09UN2vG0MSms8GG7YdTqyjq4J9kzTsj1NMqv5IT1SDQ9HKi8J+VPXK4jzEpzzQjV/UgDOqyQW4/X4lAQl8h7Q2vv/JI8wxjdqs9OjnCz9Iq/INJvgBsfSxBfj0gpKt6gkTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196812; c=relaxed/simple;
	bh=MoYa4aZxKNP6PTyxdo5P0igvYdQEyUdFKxCQROmGscc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czBoFHOWJzmUcHqpU5dp4pt0cQWgxVqcSXPDdViZxZ0727qIAQ5l6C+cYRCU0Xx9Ym2P0zr2MNrYh3+g5Vp0wDXiPh4nDf+91GKDTzLIxW7plmn0HAYXFazIuKk0suHDDx0DbJ9iPPRGmcEtWnEBWWh7dD4aSV+pYm/OwhTxLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLagySuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C923C4CED2;
	Mon,  6 Jan 2025 20:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736196811;
	bh=MoYa4aZxKNP6PTyxdo5P0igvYdQEyUdFKxCQROmGscc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PLagySuDigDXTRefnGo3zvG8/JndZ7iFdXcNvlj167ueZAxpBxddDk2tJPxHpwx3h
	 Nmmgx7o8e2TfFjN+Yef1NAfwlVlsqLo2MmEoTX5VGy4gDb0FXyrgx735HZPopI50xL
	 GfUt4htN+tQURtyjNS+Vlra95fqYETnl08GGNNnXvFTEY1rkFlaBWViOrE0Psv24GM
	 U4FWpYklqikk6mAvPhbdKh5cmT8d4Fic/mtTdh98ktnwWrZGhl4C3bzB0nlSWffnVs
	 AdXmtcWoQDOUUTIVlqanRsVH19MRqvU62cly9VNxvfew7M2u1qG5WOQyxkutW0ddI3
	 /6RomMmXdwopg==
Date: Mon, 6 Jan 2025 12:53:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v8 4/6] octeontx2-pf: CN20K mbox REQ/ACK
 implementation for NIC PF
Message-ID: <20250106125330.15cf523b@kernel.org>
In-Reply-To: <SA1PR18MB47094FA3D15F05C8EDFC02C1A0102@SA1PR18MB4709.namprd18.prod.outlook.com>
References: <20250105071554.735144-1-saikrishnag@marvell.com>
	<20250105071554.735144-5-saikrishnag@marvell.com>
	<SA1PR18MB47094FA3D15F05C8EDFC02C1A0102@SA1PR18MB4709.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 13:08:29 +0000 Sai Krishna Gajula wrote:
> I have pushed V8 patchset for CN20k mbox module yesterday, as the
> previous version got deferred due to winter holidays.
> 
> We see below warning/error message for patch 4 when compiled with
> clang options. "netdev/build_clang	fail	Errors and
> warnings before: 162 this patch: 163"

It's a known problem :( Unfortunately one of the core headers
(linux/mm.h, IIRC) generates a warning when build with latest 
clang, so we get false positive failures. Hopefully this will
be fixed during the 6.14 merge window.

If your patches are still in an active state in patchwork no
action is required on your side.

Adding back the list, please avoid removing CCs.

