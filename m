Return-Path: <netdev+bounces-177482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31398A704CD
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AEEA7A236E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A911425B683;
	Tue, 25 Mar 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap9ZfMAj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107625A2B4;
	Tue, 25 Mar 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915890; cv=none; b=Rzl7QEK6mJ/cxV78p/a/Gi/wC/esM2FutrRBkyvREVbOE6MouDtrdhoNrhJPLdiDlOxZmV+9uJ7+Ltqk8M3o+zW80zGkD2zcJ9gUFPErDyel4z47vEyuKxuZRZXRoY/0rxiNZseb+Dh0Xy/XN1LcJQLOz9As5BWfoIw0WENxWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915890; c=relaxed/simple;
	bh=Vpd5GeG6Mp06dZYbUW5WcOk7AYIJQGulxX8EOSHF2dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KadLL320mbAyaP9aoMYHXASZFJ5j9FQE7U/a8IM2v9FlDgDY4OA/R7Am+Z32ruxsxnNa+SuyTd3o8+IkZEKOS2ZmFEn6MIal2XFtzRIQBlKuvEKhtJW9P7zeI0xw9493e7t5F8ABKOLRuGw5XGE7NLClLWGZcvCT8RBKujpiDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap9ZfMAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C654C4CEE4;
	Tue, 25 Mar 2025 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915890;
	bh=Vpd5GeG6Mp06dZYbUW5WcOk7AYIJQGulxX8EOSHF2dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ap9ZfMAjPGQlKbyKbnul4t1wyk3xZP61liBgD02DdCiVE99XqMsQG2oWSVuVNy4fh
	 mcEineyVLhKL8MkTv2qYTTjjSmVo0/U7zc+g7AKcwAVGlTixjID3DvJt6c4iuHKH0E
	 poy6IIUxgk68Cr4UX7yV+NtEu1c0xcwk2fUI15U9lAjsKIhUJ84A/4pVFkmvZ0cySG
	 LUVHakpDxjT3pdo1wfLiw84FD11eE02kbhf9YYpBmK/kmjhXNzHS98onYVPK2sdzQC
	 6l2XNuxrBIQv8Yphdyv9JsxjljRxlX2MY1WEDy3HCG/RZ6P4EH0JCaUW44DD3erYVO
	 YsbPgbatm2BAA==
Date: Tue, 25 Mar 2025 08:18:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth-next 2025-03-20
Message-ID: <20250325081803.4fa1e08f@kernel.org>
In-Reply-To: <CABBYNZ+b31WUEB_H=ZWCvjOSGMpoHpxCZZs5OrMw2uaqbCxQqQ@mail.gmail.com>
References: <20250320192929.1557825-1-luiz.dentz@gmail.com>
	<CABBYNZ+b31WUEB_H=ZWCvjOSGMpoHpxCZZs5OrMw2uaqbCxQqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 09:07:42 -0400 Luiz Augusto von Dentz wrote:
> >  42 files changed, 1890 insertions(+), 268 deletions(-)  
> 
> Is there a problem that these changes haven't been pulled yet?

We were behind the ML traffic by significant margin, see:
https://lore.kernel.org/r/20250324075539.2b60eb42@kernel.org/

Could you please mend the Fixes tags?

Commit: 25ba50076a65 ("Bluetooth: btintel: Fix leading white space")
	Fixes tag: Fixes: 00b3e258e1c0 ("Bluetooth: btintel_pcie: Setup buffers for firmware traces")
	Has these problem(s):
		- Target SHA1 does not exist
	Fixes tag: Fixes: f5d8a90511b7 ("Bluetooth: btintel: Add DSBR support for ScP")
	Has these problem(s):
		- Target SHA1 does not exist

