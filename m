Return-Path: <netdev+bounces-80963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB928855AB
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ADE1F23F91
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9E658ACB;
	Thu, 21 Mar 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lynne.ee header.i=@lynne.ee header.b="J5ur5qdj"
X-Original-To: netdev@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECE1DFD2
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.6.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009756; cv=none; b=oUbCSi3FClUR/J7NCkCdofafId3F9TK1HIc4bYcxKfXi+fTCOgi2XxENHDc/mCATfeHDJyxeSKaLoYe0tAyLKJsv+cqoIL0Ro/4luxvWnwlZooop+Z1XS+o52PIL4S4XtzCRpIeM9pwTzfW461lCJamv27oV1R5ih5/ADflBcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009756; c=relaxed/simple;
	bh=2V1nTFt2diEohmhfAUKGzJ0EWP63RxdFbT/k7yY4lZE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Vb3vKOBwzC97m3TYj2I/KbujD09EJUk9UrS3b4vMLrTFIn2GIXDFCAs7+MpjXpdoHCaEIaWKp56Rd+uTWwZUnMo6SMqEjKPLY7mRxJ6C81g8YVmNhBVe9PvMdqHVm5afUof6bUX9oLN5RFLScjvdXMLgVyhzJIHPJJjyl08SR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lynne.ee; spf=pass smtp.mailfrom=lynne.ee; dkim=pass (2048-bit key) header.d=lynne.ee header.i=@lynne.ee header.b=J5ur5qdj; arc=none smtp.client-ip=81.3.6.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lynne.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lynne.ee
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id 6CAD41060254;
	Thu, 21 Mar 2024 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711009743;
	s=s1; d=lynne.ee;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=2V1nTFt2diEohmhfAUKGzJ0EWP63RxdFbT/k7yY4lZE=;
	b=J5ur5qdjhZwdS+BBCfRu3lhSEs7waEmDuoQ3tAN2iN5xzTNor4KRJX1uG8Khoj1x
	G4+wiUt0qxR79i5ckjI02S94aJ4W8oIUsdTF6wHYsom9u/3pwf963++XH9DjiHZcaSv
	9Bq33JrNRCkZtZPpzOYC8BsUr28FCI4g18OKeaMUUXC8FXHI5Fi9XJUmVmjQzRxaiHi
	JLUaw1UMg41eLsdoLhlr5Y0XLm+BVQkrpDB7DeHNkltzV7oW0p21eajZRJrdUlxPtWL
	/0Zx0648nl0kUlf289/oN+w33kzxZuzAhvS51ov55GswCKlMSn+Y+O9WIeqga4MgWPH
	Awps5NJPaQ==
Date: Thu, 21 Mar 2024 09:29:03 +0100 (CET)
From: Lynne <dev@lynne.ee>
To: Netdev <netdev@vger.kernel.org>
Cc: Kuniyu <kuniyu@amazon.com>,
	Willemdebruijn Kernel <willemdebruijn.kernel@gmail.com>
Message-ID: <NtV7B0y--3-9@lynne.ee>
In-Reply-To: <Nt8pHPQ--B-9@lynne.ee>
References: <Nt8pHPQ--B-9@lynne.ee>
Subject: Re: Regarding UDP-Lite deprecation and removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Mar 17, 2024, 01:34 by dev@lynne.ee:

> Hello,
>
> UDP-Lite was scheduled to be removed in 2025 in commit
> be28c14ac8bbe1ff due to a lack of real-world users, and
> a long-outstanding security bug being left undiscovered.
>
> I would like to open a discussion to perhaps either avoid this,
> or delay it, conditionally.
>

Ping. To be clear, I am offering to maintain it if the current
maintainers do not have time to.

Should I send a patch to remove the warning? I wanted to
know the opinions of the ones who maintain/deprecated
the code first.

