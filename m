Return-Path: <netdev+bounces-162236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27915A2652E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91713A43AA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DCE20E71C;
	Mon,  3 Feb 2025 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWRGG/Qd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB420E01D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616369; cv=none; b=LoeNGKLDbNvd76+Cr64CiSM7FkeEEIdjgwdE8Lgx101PU09LyRR/+MZr8GkvS4DGPZjXeUCG5FdM2uQ0FbEGHBZ/ZuyW1lt5fwFGpURiiAJIFcVt7dkyGFEAEAF7xeDaiiprhlUXBLu0D5pqoyq1WK4Zbe5ZqIqA9cfZs3gVcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616369; c=relaxed/simple;
	bh=ANXxWTczOKdij/0TwMJlPn7l2toGFxbhuMXPgb0uU6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfN4JPP882Ufn3Mb8bw9eB2fwsZ+e46emeb+IpDqmRJX3yL1BmRluujiji+t1gE4UF0xOD/k7gKfU6aGE027ROISvrb5uU8OWQEKJsbAkiNgZcATxi6kZTflsTtDR7bPKCEwo/qbbYHJ3Z/NIorvXu3Bxsjc1aeu5Sc/Jmk9CKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWRGG/Qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655A8C4CED2;
	Mon,  3 Feb 2025 20:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738616368;
	bh=ANXxWTczOKdij/0TwMJlPn7l2toGFxbhuMXPgb0uU6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CWRGG/QdklLrHO/7KYogOhZJo2TWWH2poV5DV0UdcEwp2thuyOy3IF8KxyFV6rvhX
	 +D/UlqDdSAvoHoF8MicpPjyv0h99bmyjSz5CIERT3JF565YyeNSopy0tKAm8ljySQX
	 rHtOk2T/tMZ5IYX3c3YMHcfFAXdOKz/kAFoYDk1RfGzUb4Yxo3QMC/cx5B92R/9PFY
	 RDAuA2zQIBcL3MdxuED4AJ4q+CcFFNiziKak4FYsz4k+UGh/o7k1/FY9LvZ7XnA1BU
	 MkkdqgtB+zDXIw2gq6x7VQqYJyJrSbXhabWdoEjA6walk4BP5/uYGTPDXgSz4wogFE
	 5dlqXmQr/n1PQ==
Date: Mon, 3 Feb 2025 12:59:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
 <mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
 <amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Message-ID: <20250203125927.3072e386@kernel.org>
In-Reply-To: <DM6PR12MB4516414BC58997DB247287CAD8EA2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
	<20250127121258.63f79e53@kernel.org>
	<DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20250128140923.144412cf@kernel.org>
	<DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20250129171728.1ad90a87@kernel.org>
	<DM6PR12MB451613256BB4FB8227F3D971D8E92@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20250130082435.0a3a7922@kernel.org>
	<DM6PR12MB4516414BC58997DB247287CAD8EA2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Feb 2025 18:22:18 +0000 Danielle Ratson wrote:
>                 "type": "object",
>                 "properties": {
>                         "br_nominal_units": {
>                                 "type": "string",
>                                 "enum": ["Mbps"] },
>                         "length_(smf)_units": {
>                                 "type": "string",
>                                 "enum": ["km"] },
>                         "length_(om5)_units": {
>                                 "type": "string",
>                                 "enum": ["m"] },
>                         "length_(om4)_units": {
>                                 "type": "string",
>                                 "enum": ["m"] },
>                         "length_(om3)_units": {
>                                 "type": "string",
>                                 "enum": ["m"] },

Hm. I would have expected properties to match the main output.

So:

                 "type": "object",
                 "properties": {
                         "br_nominal": {
                                 "type": "string",
                                 "description": "Nominal bitrate. Unit: Mbps" },
                         "length_(smf)": {
                                 "type": "string",
                                 "description": "Unit: km" },
                         "length_(om5)": {
                                 "type": "string",
                                 "description": "Unit: m" },
                         "length_(om4)": {
                                 "type": "string",
                                 "description": "Unit: m" },
                         "length_(om3)": {
                                 "type": "string",
                                 "description": "Unit: m" },

