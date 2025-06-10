Return-Path: <netdev+bounces-196331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BDAD4468
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945F33A58F4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC22267397;
	Tue, 10 Jun 2025 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbpklLoS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86912D758;
	Tue, 10 Jun 2025 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589647; cv=none; b=Ed4F9hGkZwU3nBh7bt90E0e33MDkBQbdDN4WwZamaFqHk9n9JHZgch2ARKhcQSUWhoGJezEMHMzzGp4n+nnHkEUiwDMxIdYgBrrEifliOwgtvMch7vG1X89hoLwaVhpghwmyDMw6CNcj8dODPdGBMsWvDi0uzOTYS6hX1dnPvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589647; c=relaxed/simple;
	bh=te1FdrXugcXRYIBb9LoL9C21gyeVfuv4ldM2Dn6btwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6ZMDLf+sDCHdGrtOz1fAkAiL7Zoe4Bbs6Du78r/U6/Ol9bycKeQttWVCzXlM7voTLTNLxIlk9XnPbOCdhtlmxyNAMkAPy8yvRBFa/7kyErznyAb2YBgz+DN44XTR8GjruBVox2qymg4C+a0x+HdemT9EC2XhIORJpEdDKEbgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbpklLoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E0FC4CEED;
	Tue, 10 Jun 2025 21:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589646;
	bh=te1FdrXugcXRYIBb9LoL9C21gyeVfuv4ldM2Dn6btwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbpklLoSTfodJA5IhC/nO8yMbqDmJmNT5/5PyH0f4cDgkQ0QXXHiTBsrVgaZW4LGf
	 t9igAKwH0C3GglINz0EnseKzRBY1j5P8YvQAi4aJZZHP7tFbUd2RAE2zztgqyoDmpz
	 gO32U0NpYnk4icx2pxPqh8o597YTzTuQqU/lCffP/Z4WFiwSVBvPOzWlS0i15O9+/R
	 e7elXqzIRl5VCt6pwz9ccvGWYaWOFoglylnHNossHOJNq04Z5TKRnuy1+K5opXu0gs
	 G4LHWHTMN8kHcRpXvVFPcRWUpOqo4p5cbRN7HYocsjoDy+CDg118vHw6X4FeZkEs2U
	 QXQiZeXEuKl/Q==
Date: Tue, 10 Jun 2025 14:07:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Akira
 Yokosawa <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan Stancek
 <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
Message-ID: <20250610140724.5f183759@kernel.org>
In-Reply-To: <20250610225911.09677024@foz.lan>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
	<5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
	<aEhSu56ePZ/QPHUW@gmail.com>
	<20250610225911.09677024@foz.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 22:59:11 +0200 Mauro Carvalho Chehab wrote:
> > The question is, are we OK with the templates that need to be created
> > for netlink specs?!   
> 
> If there's no other way, one might have a tool for maintainers to use
> to update templates, but yeah, having one template per each yaml
> is not ideal. I think we need to investigate it better and seek for
> some alternatives to avoid it.

FWIW we have tools/net/ynl/ynl-regen.sh, it regenerates the C code 
we have committed in the tree (uAPI headers mostly).
We could add it there. Which is not to distract from your main
point that not having the templates would be ideal.

