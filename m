Return-Path: <netdev+bounces-24565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D944D7709E1
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124AF1C20AEC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2B1BF0A;
	Fri,  4 Aug 2023 20:41:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B7CA61
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 20:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A17BC433C8;
	Fri,  4 Aug 2023 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691181677;
	bh=LbRMeJd1Y/h/HbikMxpBiOVXW7SKMN2sCPKnVjV0j68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+X8KbPfkqubWWb+C/tz4HaBorGHtpr8xeT/DMoq+etQNRJ6Z4OXZUHpnj0vELFmv
	 lisJFr4yYOntv5TrH01aaRzWM6GcEqAg9CoNPDcFIA5OSpMWPqq9kcl1o9Kd/jsIoU
	 jAFeD1qqt3KHV6xNGSPRFyMA/xiSlphsJu5c/Z3p4kPMw2XT6XtYyFCBjT0NHmmc2/
	 X6rVG1Gmt9Ry/G6FNdeyKHppKhoOfGqbE22G5hdZRzX17pOhZPqO/lT2ar/LDdl5v6
	 s8EwJ2dL6E0yV2Wx2KGYDi/vhsEHueG+iNBUiI15EEaKnO534265bVryuLpbNAk9S4
	 GffVOW0JwIfIA==
Date: Fri, 4 Aug 2023 13:41:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
 Karsten Graul <kgraul@linux.ibm.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net/smc: Fix effective buffer size
Message-ID: <20230804134116.6a1c7f40@kernel.org>
In-Reply-To: <c493ef8fa5b735fe32be0c720be77db18e660dfb.camel@linux.ibm.com>
References: <20230804163049.937185-1-gbayer@linux.ibm.com>
	<c493ef8fa5b735fe32be0c720be77db18e660dfb.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Aug 2023 18:55:26 +0200 Gerd Bayer wrote:
> this should have gone as v3 against "net" instead of "net-next".
> Resending ASAP.
> 
> Sorry for the noise,

Less apologizing more reading of the rules, please.

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

