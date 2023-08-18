Return-Path: <netdev+bounces-28689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E4078041C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 05:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B696728224C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4363C7;
	Fri, 18 Aug 2023 03:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF4380
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 03:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39B4C433C7;
	Fri, 18 Aug 2023 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692327761;
	bh=C+qb50i/AzAs7tmX3ps1WN6qoUMah+yzD4vKL0B6vZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m0rzyzPD5FejdY7HoEQzgw6hi7jQNoPmXKG14VsIV4NxVZAsWdhEm0Hgt4qllW/q7
	 t288bqiIDR6A/6VTNAxyriyMfCtta7uEKsm1wqLgRURZdyV9u1EiaPLwPl1pxPxfQ3
	 k1Kg6zKnHcbFLiSwHxFVu9C/uUh5hzFhNRvl1rb4HaNRNWz2VmtSPeUlUM4Sc+l46V
	 GrSNQD8zpcmZH21hJFMXvQyfClYuv8rS1KtjEe9vROSfsSwzMY0OjJj65DNjvCY5yL
	 eIyWbiONH4ysCNHgFNv300cpkWyobvQHBqLGmJQirIxTgXzA5de20nzFiZMV5aDKKn
	 jKs3+CKifweOg==
Date: Thu, 17 Aug 2023 20:02:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Joshua Hay <joshua.a.hay@intel.com>,
 pavan.kumar.linga@intel.com, emil.s.tantilov@intel.com,
 jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
 shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com,
 decot@google.com, andrew@lunn.ch, leon@kernel.org, mst@redhat.com,
 simon.horman@corigine.com, shannon.nelson@amd.com,
 stephen@networkplumber.org, corbet@lwn.net, linux-doc@vger.kernel.org, Alan
 Brady <alan.brady@intel.com>, Madhu Chittim <madhu.chittim@intel.com>,
 Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 15/15] idpf: configure SRIOV and add other
 ndo_ops
Message-ID: <20230817200239.7d2643dd@kernel.org>
In-Reply-To: <20230816004305.216136-16-anthony.l.nguyen@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-16-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 17:43:05 -0700 Tony Nguyen wrote:
> Add PCI callback to configure SRIOV and add the necessary support
> to initialize the requested number of VFs by sending the virtchnl
> message to the device Control Plane.

There is no API here to configure the SRIOV, please drop that from 
the next verison.

Sorry I run out of day. My comments so far are pretty minor, feel 
free to post v6 without waiting the 24h, otherwise I'll take a look 
at 9-14 tomorrow.

Please add my Acked-by on patches 1-7, if you're posting v6.
-- 
pw-bot: cr

