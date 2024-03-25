Return-Path: <netdev+bounces-81622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2B88A81F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9F81C63025
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB5E13118A;
	Mon, 25 Mar 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkZak18l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202135CDE4;
	Mon, 25 Mar 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374156; cv=none; b=uEfQzaAFqMDiz5AFz/srzSwKuNbswlwgzUALHTGqAdkcqE7QU+RM1lHQt2xcegILkFkHWML9+lQNfdjX9Fou5UOru4+2IpONsTl/Y0bpMOxPVLwHfdmewTMomql9yke9FEuufeaUw2YfTHuv4w6stE7KxZom+oSvruj9aDDI9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374156; c=relaxed/simple;
	bh=+rXd4LJaa3OiXCGM2nLdIlcVTslxO5WGU3r+799XrDQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=eU2W0b6RAo3ydGZN2SPBrpidj9xMPZEEjomu7F6BH6pkLCk2fQqJUxYJ4q0XWgjltXvY6bfQaRNdOONfCOQKqxzMUyPWWAwTl7g4l/9GWqPjvtPm06j0QfP+vhiyQDaLBZ1ETpaRwA9L4tKLZVbF0GSt/c/wRzaGwd8gp9J63Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkZak18l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E26C433F1;
	Mon, 25 Mar 2024 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374155;
	bh=+rXd4LJaa3OiXCGM2nLdIlcVTslxO5WGU3r+799XrDQ=;
	h=Date:From:To:Subject:From;
	b=dkZak18luUM+OIh+6VVDIzB28i5Gv/vNyww0VsFRhF0QuP67tkgP4C5RdAq/RSvjL
	 KvZzxyrwu8msVp8M6AbO5r9hTFg8yfAe+NQwl20CP5tF08Rf9oj/JgLS22kzCyco5a
	 qBQCy1qURDdOTTnDApSzkwt82Tio//hcF90Z9xsdDk9DhrgeX6rIDGWatCGBYelAhW
	 C8CwZv3DLP6guCtVrfww4+dvfSi74EgovMoGbEYQemenKQ9M7rEXRK2ynBqqoZjyJS
	 cIRghyS75Uw8yEXYWPmk9qzIHvOS+NI6Eh2ZDiYbJGLIHwLNhRmKBc3qOcuCetY6Q5
	 japH1FNHwjEOQ==
Date: Mon, 25 Mar 2024 06:42:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20240325064234.12c436c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

net-next is open again, and accepting changes for v6.10.

We seem to be in a good enough shape. For those trying to run selftests
locally - 9p has a UaF bug, see the testing tree for the fix we're
carrying locally. The changes in the timer subsystem also made a number
of tests flaky, beware.

