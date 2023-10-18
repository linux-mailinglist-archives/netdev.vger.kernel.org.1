Return-Path: <netdev+bounces-42334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9DA7CE586
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080CE1C20506
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799363FE36;
	Wed, 18 Oct 2023 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0cSHS/2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AA3FB39;
	Wed, 18 Oct 2023 17:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC27C433C7;
	Wed, 18 Oct 2023 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697651826;
	bh=JofSflLWtggV8URpWNuqKetCfBtt9egjfPL+AtxClcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H0cSHS/2ehHG2JNjTx2sCWDMBQGHbTRUdGfIJPR32ZYkHmaKW3xB5IJNUQshZ+LIN
	 g+NlnxCGi0wM6yll3Jfh3iE3Yk6GF8jcJ3ZNSaxzjYIRUtFEaVxPgUr5Gvn+RDSOXm
	 BHwX4oRLnpqmdsb+BLwpfW3QtvFohCNu5ET8xEb3c156uzxXIP/Wm4piE00x7k1Qjq
	 4MlWCEL64X9Bn6IwIObodMvUyiqoadwwSBgT8WY8zls6QaaBrsVLWK34B1wi0QPdx6
	 isL8Z5xcB1iaGAN8elbocYzDsjWPzLkSXPBJf0/b/3fMQfHxeOxs9vYdtleqgIUovK
	 sp+PbinN1obLQ==
Date: Wed, 18 Oct 2023 10:57:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 corbet@lwn.net, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/6] Support symmetric RSS (Toeplitz) hash
Message-ID: <20231018105705.556a6cc9@kernel.org>
In-Reply-To: <20231018170635.65409-1-ahmed.zaki@intel.com>
References: <20231018170635.65409-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 11:06:29 -0600 Ahmed Zaki wrote:
> v5: move sanity checks from ethtool/ioctl.c to ice's and iavf's rxfnc
>     drivers entries (patches 5 and 6).

What about the discussion with Alex?
I thought you'd move the flag out of RXH_ into a separate field,
key-preproc, sub-algo, whatever..

