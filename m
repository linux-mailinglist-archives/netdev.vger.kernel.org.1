Return-Path: <netdev+bounces-53571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F5803C71
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D392CB20B71
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE2E2EAF2;
	Mon,  4 Dec 2023 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtsdjXt8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364B2EAEE
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 18:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B97DC433C7;
	Mon,  4 Dec 2023 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701713256;
	bh=oD8tN/J0l/ijVRAkq2l6c3045I2fzgg51LecwK04xZ0=;
	h=Date:From:To:Cc:Subject:From;
	b=AtsdjXt8ZbyH0/wQUN3ZLgTPfUS49VEJqmgXJyPggodPnIwtm6f9ON/IyCdIt+Fr+
	 mrt8T4vB/b29lMNZeqZZa1OK4gJeYwMWEuYTQn/wA5z8TWKM+c0rnZiOXX/vTUD9Sd
	 sIfQcidbztP1HIXqXGAMUlmtYkfsF0UvRqN2GnXsDAWwhPJnCn09jwgyRthAYNzUPX
	 J/khraTy8yAisxPN6vF1Bw/Czc8n16aUH2EeklWfB8YrpetiJENbIIQpqmz17eChbg
	 bPNY531m0TfDA926Fm+GLQ+jsY80A4oZdrI9QVtnDesU3oYhkIUTIgAc4b2DoGgmlG
	 yE+rbVxmUx+QA==
Date: Mon, 4 Dec 2023 10:07:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [ANN] netdev call - Dec 4th
Message-ID: <20231204100735.18e622b2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).

I, again, have a minor update on the CI. I'd also like to talk about
end-of-year shutdown. Please suggest / come to the meeting with
other topics!

In terms of the review rotation - this week's reviewer is nVidia.

