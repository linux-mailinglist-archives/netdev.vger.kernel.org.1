Return-Path: <netdev+bounces-12809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938C738FEF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FAE28174B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF21ACDA;
	Wed, 21 Jun 2023 19:21:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EEDF9D6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FDEC433C8;
	Wed, 21 Jun 2023 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687375268;
	bh=Umi/WQ5JaYPeZNJQnUl5tcXK++EHRReY9kyGcep6i50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P3L+ynThoam9C4GlaWJrz20dDnRkL92AOH5H2Znm+7q3OPpUvyWSGhUpyEhpDG/Js
	 s+/LaPM8W5jdtm5jq8JkQcPN4MeT1Dn3nSqda+sv7rDVo0cmMEf3PDLJfRSnwRGuZb
	 DHW3c8AqLPrcioYbBkdWusuA8UV82qT4XfkxePgdOeX3xRtXTUYUl5nmrHj1eu52Hg
	 TNbVc4W39JvpB4Hqjiusby3xqjbSTUkMQUnIc4JUBoQ0Y3iasIK7k22Anakyp8uSlq
	 SpzZjtIEwy/s4bb86ltda3bDypHFQNFI1JUEyYguMrkZOF12qoPbROnjOTkbeo39zd
	 mQ+/U9V7W8kKg==
Date: Wed, 21 Jun 2023 12:21:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, Alan
 Brady <alan.brady@intel.com>, <emil.s.tantilov@intel.com>,
 <jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
 <shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
 <decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
 <simon.horman@corigine.com>, <shannon.nelson@amd.com>,
 <stephen@networkplumber.org>, Joshua Hay <joshua.a.hay@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v2 12/15] idpf: add RX splitq napi poll support
Message-ID: <20230621122106.56cb5bf1@kernel.org>
In-Reply-To: <9528682b-93bb-2797-6bd5-0f40710d306c@intel.com>
References: <20230614171428.1504179-1-anthony.l.nguyen@intel.com>
	<20230614171428.1504179-13-anthony.l.nguyen@intel.com>
	<20230617000101.191ea52c@kernel.org>
	<9528682b-93bb-2797-6bd5-0f40710d306c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 12:09:07 -0700 Linga, Pavan Kumar wrote:
> > If you want to do local recycling you must use the page pool first,
> > and then share the analysis of how much and why the recycling helps.  
> 
> We are working on refactoring all the Intel drivers to use the page pool 
> API in a unified way and our plan is to update IDPF driver as well, as 
> part of that effort.

It's a new driver from the upstream perspective, it needs to be brought
up to date before it gets accepted.

