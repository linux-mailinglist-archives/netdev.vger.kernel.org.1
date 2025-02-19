Return-Path: <netdev+bounces-167601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE09A3AFED
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AC83ADC96
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745D1925AF;
	Wed, 19 Feb 2025 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2nPJpux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10771805A
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934581; cv=none; b=fdaPWENeH+kRgUgAFal6Dmd40lJUqW+hC01LodJBA4dDbmQfeEckeMLISp7FsLDcM+7ML75++iB5LSJsWhllogZC50S1UOV52h6ZaSJRo/0PMZUc4WLsELC+xIVzbHph+02ulA0tVK1ZgWvZE6i/Xic1/LxDGQ/vlbhUbwU33Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934581; c=relaxed/simple;
	bh=mptR9/RxB+uczbQtx2gMpn1XclYx0YGYTj1KT84AL5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiXPHc+mOGFUywmvao2juqHQ17cJpLeavc77odWB27jtktbcW8TgS+CoDrmMSG2fIlVGO6VNfp3GIq4Zv5KqGLMlrlzYmYwjnKCf1BdQ4egN+IY2NnndSulezcVcIt84bjLHGUTKGvvBpXomrwdrHufD26ZvJ7p7obm+ZQjWPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2nPJpux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A8BC4CEE2;
	Wed, 19 Feb 2025 03:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739934581;
	bh=mptR9/RxB+uczbQtx2gMpn1XclYx0YGYTj1KT84AL5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y2nPJpuxB6hiQx0K1wpxXQDDav7fB15OTtqX6XThhUDPAsrY9bOM+RPXgVh7NlSu2
	 RD9YN+nVfL6MBOjxlwG2gPeCMgV1WMqmlIh+2MCc9S8KpzcPwhM/cb/AB/qumt3Iy7
	 1NWqSKrEQH+r+ztP6zP0t+M+yf7mM0Ab/bPtbEhjH3f1P0NHsumJo32pvYVMf+2rhe
	 jAkvSDJ3kKgurBmUxKyo4xRHwcG1y1Fl7gWtMVOs1Ayschbf939ko1OFD9n9PNG1a5
	 yhAclojyzxNgRHjitQw/nKLr+ftON+DV2A4NVCaDltxUesiBCLb4FFPrvPW1GwX08L
	 ZXXUaDo7CiQ1w==
Date: Tue, 18 Feb 2025 19:09:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v4 10/12] net: dummy: add dummy shaper API
Message-ID: <20250218190940.62592c97@kernel.org>
In-Reply-To: <20250218020948.160643-11-sdf@fomichev.me>
References: <20250218020948.160643-1-sdf@fomichev.me>
	<20250218020948.160643-11-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 18:09:46 -0800 Stanislav Fomichev wrote:
> A lot of selftests are using dummy module, convert it to netdev
> instance lock to expand the test coverage.

I think the next version should be ready for merging.
What should we do with this patch?
Can we add a bool inside struct net_device to opt-in
for the ndo locking, without having to declare empty
ops? I think more drivers could benefit from it that way.

