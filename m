Return-Path: <netdev+bounces-41385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3EA7CAC92
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7311C208E5
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1D28E01;
	Mon, 16 Oct 2023 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBaHa4rN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188FC266B7
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E9BC433C7;
	Mon, 16 Oct 2023 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697468180;
	bh=WUnDHVUOqfcPj5bVg+fqz9I2iqfRHmXakB6J7g0FSl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tBaHa4rN2f9ZyQl8PO3D969/xIInxobp0Agmgswj4NYeEzKJt+Yd7gKTjQ85y4/ps
	 vONoeTQn9sA1D7eJw0BeGNIDBFDXBgu+cuyXsm0PM88sEj5UgAictN722B3haxDhad
	 I8nV4q4exbAqN6Mf1a7NbrUxI+lkf7ptzG8ZcLVnkXBn+UcNjHyo7wQMy4+E8reMGR
	 oLr7pUPkemFg0Z9yIifcwLdr2ubw6+/6+4vQ10oomAedeksnDJYLfQRhLIGPWjrmHz
	 RKO7CgX/X464Ldl5bpLeK06sAMOI2ULsNx8CFVejQ6OH5HgMjjZE1lWyIMSt7+VHKy
	 4jbKvne1+vUEw==
Date: Mon, 16 Oct 2023 07:56:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next 3/5] i40e: Add handler for devlink .info_get
Message-ID: <20231016075619.02d1dd27@kernel.org>
In-Reply-To: <20231013170755.2367410-4-ivecera@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
	<20231013170755.2367410-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 19:07:53 +0200 Ivan Vecera wrote:
>  "serial_number" -> The PCI DSN of the adapter
>  "fw.mgmt" -> The version of the firmware
>  "fw.mgmt.api" -> The API version of interface exposed over the AdminQ
>  "fw.psid" -> The version of the NVM image

Your board reports "fw.psid 9.30", this may not be right,
PSID is more of a board+customer ID, IIUC. 9.30 looks like
a version, not an ID.

>  "fw.bundle_id" -> Unique identifier for the combined flash image
>  "fw.undi" -> The combo image version

UNDI means PXE. Is that whave "combo image" means for Intel?

