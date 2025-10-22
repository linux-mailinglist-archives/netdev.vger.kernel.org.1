Return-Path: <netdev+bounces-231692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F6FBFCB97
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B706E36D8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438B34D4DB;
	Wed, 22 Oct 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxffNB4L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E823347FEC
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144497; cv=none; b=fwZhTUSlq9aQlNwnr6KD7q/zSYY6M1ybXmxLi4WbtX4zt7k3PsJpW0Iu/mUH1xWeoHJBjPqKwAyO77G0aNi+B7UdwLXVkTd/kKcSU7EP0LtY5F8CNe7f7UZ6WEW117UzbJ7pN+t6QJaCVMHTag9kwO6t1TV5TlmmzpVRpo9LM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144497; c=relaxed/simple;
	bh=3EkH0sa2eXpE4fErqxGg2HLpYctPFuUlQHQ8YpxpWMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPF1I3WmvONPgg8WBom94QgMFq52wFxcvRqvd7umiNJBOxZj8Pk4XL16mLkyF6eypVwDdYt8m2qsu1p2aGJjNILwj58zzQvwKLiczvf95P5ioLdtX+Xc3kaBipFyiFcDmtswIptn2J7tOEdCsT/JEFy+pFfV9k3NbLYnSxr4B74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxffNB4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C378AC4CEE7;
	Wed, 22 Oct 2025 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761144496;
	bh=3EkH0sa2eXpE4fErqxGg2HLpYctPFuUlQHQ8YpxpWMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxffNB4LsLQ1/IdjCbmcr0ovnH3/ifdnsyNzy5wTP5cFItXN+4UsJ8H8ing8vHu6f
	 GcUVsfrT9cTI41kmq4NHEgYVjqkTpS7t6cXwFZMb9HKR3eqAdxkuJ0tXYrc/ikM/td
	 SQsLWvd0tYEEwetsqgU6thRFODS2loYtX5He20QpeNXVye1kLlqxEIicmBBg2JC5BC
	 GI4tmBTQkzvt1jUszH6O3EjHTfxCRZYTdl3u3AnvwbXPc23lv/Dnb4wu7v0g9quCph
	 2Cc9E5ejALTgjKnEgS479F1dF9iqTWPcLGzLJJ1DsM7p4gT1vbRSiFvR8RYkyQ/0ri
	 0bDbGEVEdsnxA==
Date: Wed, 22 Oct 2025 15:48:12 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] igbvf: fix misplaced newline in VLAN add
 warning message
Message-ID: <aPjurC9zjCBX1A_P@horms.kernel.org>
References: <20251021193203.2393365-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021193203.2393365-1-alok.a.tiwari@oracle.com>

On Tue, Oct 21, 2025 at 12:32:01PM -0700, Alok Tiwari wrote:
> Corrected the dev_warn format string:
> - "Vlan id %d\n is not added" -> "Vlan id %d is not added\n"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Interesting, there seem to be some other cases of this, at least under
net/divers. Do you plan to address those too?

In any case, looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

