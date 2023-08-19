Return-Path: <netdev+bounces-29017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6394A781697
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D411C20C40
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B8807;
	Sat, 19 Aug 2023 02:15:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA7653
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DE2C433C7;
	Sat, 19 Aug 2023 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692411316;
	bh=dncZZ5QZJnifEb3VznABq7u2f0gVwEhLVqnS6ld9wtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iirf5ZmnCOIjmxjAGVDyxm6KXMKOXLSXaRRDGfMdB2PZQg75he1GK1P39501G3brX
	 zS7INpq8sclHQ12OFQ/EH1NzOZkoqI/mVr8yCYDOYRwyz+Lv2JsRLa8ClffezsuoTs
	 wvftPACbNDbtWjfAWUaFxjyx3g/cDxH+xzzAvOHOQxz8hqe4zUungIEsriASYiyCjc
	 uc+famy8qJuFs5IOssP2Ildz0nODtdACRMhg0WOPN0+eA2xnDDTLZcZLTSpOGWZwV6
	 1n/RDYe8lPLk8hUvAWkvfflS1soefOQTTwq2yknpdsUBIrET5B7sk/cA7nvJab2+u+
	 bfHBwyZlEAFVA==
Date: Fri, 18 Aug 2023 19:15:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net-next v2 0/6] bnxt_en: Update for net-next
Message-ID: <20230818191514.06b9d7af@kernel.org>
In-Reply-To: <20230817231911.165035-1-michael.chan@broadcom.com>
References: <20230817231911.165035-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 16:19:05 -0700 Michael Chan wrote:
> - Saving of the ring error counters across reset.  

Thank you for following up!

