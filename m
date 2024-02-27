Return-Path: <netdev+bounces-75329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B8869894
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FF928DE02
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518001384A6;
	Tue, 27 Feb 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/qs71qC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789916423;
	Tue, 27 Feb 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044780; cv=none; b=hr/fjOnFfZqlxgL0meQe1nlQkFrtOHIwnbMsDKJnI6eNcl2IGTNKReTXAQuDJ7bYAww6ei1tiJFQP4U8VkcytB5JFHM7Xxfnia18mNxlRhOt4to7BIqfMXHFUZ8EmWjfncFtwo4N1lviySVFoIDfNsdaOlVARtsNb37mUa2n6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044780; c=relaxed/simple;
	bh=PndNT+fDN9dNgLKXT3zt5FhAOqJb2SHH0GpTo/SubaM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=sTDDtdyTSOi5zWCmTnAODJ68Ds49aeYQauqoiJ1A5cKeZSptOuwg3CUuzP8yptmqMt+xSoo+O43V3y36ue/4/DLp9Xk/bnHNryf/saerY/38LbR8uFOsPdMBsICwFAa/+E5gXxT+gEEfjjE9XZV1P03NLALfk8yPbOIQHAC/eQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/qs71qC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18E4C433F1;
	Tue, 27 Feb 2024 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709044780;
	bh=PndNT+fDN9dNgLKXT3zt5FhAOqJb2SHH0GpTo/SubaM=;
	h=Date:From:To:Subject:From;
	b=b/qs71qCjhDIvFqfxL2GcsZHOr9CjSnWAS3m2sl/ei/ZIHvC1qnbGfK68WQ9KpR3O
	 9GViwC6Bm4UVbBlQlu2HHpTRwPtBPk5DLkATX6E846hu8cUc/Fs4NIZY43E+l4AFi8
	 xxnre1kY0ukB3NNDzukqW1hn3bJfyHGhRprlb0s8ZuV9JTT8LePLbA8vs+N3Jir3f6
	 fl3UdKh/kKE55ksPJtFjfw11fJizgk+gJ5446hvbRoL8emOFre+IGMC9m1EiDrqcNI
	 Zz21N+LHWqY8MO4costEwV/8nkrSVbLo0ky+je47ANuML4joHYvqvOsiL/zVQTvsVI
	 AQ3q3EgcSLTbg==
Date: Tue, 27 Feb 2024 06:39:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] no call today
Message-ID: <20240227063938.6458fccb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi folks!

There are no items on the agenda, let's cancel today's meeting.
Talk to you in two weeks!

