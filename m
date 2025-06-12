Return-Path: <netdev+bounces-196965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB3AD7285
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35906188A904
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529D24BD1A;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQvuw9H0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238524A047;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735701; cv=none; b=m5DTDbgknn+CRKBkhK/8Ta7H05dpV4ko8CrSlJIlsK3vgNfTWHTbXnSshYwuSo9gz0TVXAe9zXcPlIwV3oZuw74cy8y7mmFfVlCRYisMzsch/GwS7wEoqlE87Az8/g7yqewY0tn2c+dRXs2Z0gisRck90RhtP6ArEQoikoks1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735701; c=relaxed/simple;
	bh=LQToylDvoxpMEuXz7DwhxX+xauKJJgbGi0v6srPoxD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvHBjIDZ9MMku2ofRj+nqmRgEaJTNl6S2U/v8FAXdB+nifQp/1WYi5ywmnbm++0mjii6wIKCDspGXqHF9UE9UrTbWrYtN87+WnPM21/Ix2wrgjeJYdYxm1E3SiJm1xtjkG9a92PPJ3Daa7Ko/eUZ/VtxMnFeH6Lf1Bp61fFypSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQvuw9H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7EAC4CEEA;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749735701;
	bh=LQToylDvoxpMEuXz7DwhxX+xauKJJgbGi0v6srPoxD4=;
	h=From:To:Cc:Subject:Date:From;
	b=dQvuw9H0vzsylslwFUYwVC1oZcMDYgIa1ZdJynn5hUsmj8pf7lHI2SZhecOaK8dCz
	 MgkWZYfbniqSj3KJhn4YfAXyOpmgJnB0aYFtTNmFGsNMKzaPCjK+iUorJ7DiHcdM95
	 LLCnZPxRZvooLPh69Fe6/63eCJoYOP7GSQWG7f3UvpJrx79TRkESplfkgcmvQpWNLs
	 vsXomq88k8zPEJxTD02OOVlJxNGNgNI3CD2LcNWoWCSpLp/p8HBuzldePWS/0oPJYM
	 xOxfQmvTSqVFTfc9zTMqIyR8wMlmctsiPvpB0Ij063LtzGdOQsctd8yyopQDJLMgXQ
	 kuJE+ciVdVmZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPiBX-000000053px-0HmP;
	Thu, 12 Jun 2025 15:41:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jan Stancek <jstancek@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ruben Wauters <rubenru09@aol.com>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>
Subject: [PATCH v2 0/2] Some extra patches for netlink doc generation
Date: Thu, 12 Jun 2025 15:41:29 +0200
Message-ID: <cover.1749735022.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This patch series comes after:
	https://lore.kernel.org/linux-doc/cover.1749723671.git.mchehab+huawei@kernel.org/T/#t	
The first patch is meant to speedup glob time by not adding all yaml to the parser.

The second one adjusts the location of netlink/specs/index.rst.

With that, on my AMD Ryzen 9 7900 machine, the time to do a full build after a
cleanup is:

real    7m29,196s
user    14m21,893s
sys     2m28,510s

Mauro Carvalho Chehab (2):
  docs: conf.py: add include_pattern to speedup
  docs: uapi: netlink: update netlink specs link

 Documentation/conf.py                         | 7 +++++--
 Documentation/userspace-api/netlink/index.rst | 2 +-
 Documentation/userspace-api/netlink/specs.rst | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.49.0



