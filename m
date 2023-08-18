Return-Path: <netdev+bounces-28932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1243378130E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7952824C3
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8271ADCD;
	Fri, 18 Aug 2023 18:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6819BBE
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850BFC433C8;
	Fri, 18 Aug 2023 18:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692384465;
	bh=Bw4w54IKlwO5Gbq/HOhe7T9oSNy6Rqa4kLA+9qivFq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DG1ijFcFX/XDVo9D0/DdOLc/jB8vcDaKlkBUl0RZx+7RRPGMMD7fsssAjwqZhglAh
	 3cvbJf0/4n3ud2YlvtK84bbFizXvGJZKnLxi2BPnUrm2Q5o4bGbCZip5wSNWYgwqK0
	 pModTWcDWQQSQlcYMfnU/SsWjDYeKeBA+jW5l+fCOb8uRLvNdR7IjRICOyfqHKLwTO
	 eriLU7SdNQkKqD+Vism24nlzd79Wgm45180zLbRFpy56kWfD3YChZipZsqw69c61Wd
	 0WUBnR9AXJk8QuEe3c9ZFddsW4KzzyUdcgA8LvKNhKnkD4EMSrJvkH1Pqr/8XNQOvu
	 R1i5gMoAZXCWA==
Date: Fri, 18 Aug 2023 11:47:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Joshua Hay <joshua.a.hay@intel.com>,
 pavan.kumar.linga@intel.com, emil.s.tantilov@intel.com,
 jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
 shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com,
 decot@google.com, andrew@lunn.ch, leon@kernel.org, mst@redhat.com,
 simon.horman@corigine.com, shannon.nelson@amd.com,
 stephen@networkplumber.org, Alan Brady <alan.brady@intel.com>, Madhu
 Chittim <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 13/15] idpf: add singleq start_xmit and napi
 poll
Message-ID: <20230818114743.5ae684ed@kernel.org>
In-Reply-To: <20230816004305.216136-14-anthony.l.nguyen@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-14-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 17:43:03 -0700 Tony Nguyen wrote:
> Add the start_xmit, TX and RX napi poll support for the single queue
> model. Unlike split queue model, single queue uses same queue to post
> buffer descriptors and completed descriptors.

Acked-by: Jakub Kicinski <kuba@kernel.org>

