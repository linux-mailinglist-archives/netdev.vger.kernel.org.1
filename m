Return-Path: <netdev+bounces-164819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6FA2F453
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA27162B74
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9028256C8E;
	Mon, 10 Feb 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZM6OCKop"
X-Original-To: netdev@vger.kernel.org
Received: from c177-2.smtp-out.ap-northeast-2.amazonses.com (c177-2.smtp-out.ap-northeast-2.amazonses.com [76.223.177.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1918256C8B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.177.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206410; cv=none; b=pnYPHq5eaEce8Xmf5ESqAqr1NiGc0DfaFWJdqRbF/PVzfIREwblvpPxpawjPLm2lFL1fjQLNvdbDZmLi5ky6+yedNUkXvCUHg6+YhYfsvyVKUnsTWRH1cbB3tpLcZ9v35a1xXjjfFFzLEpsu3xWakabwcIK/CKu5PBznNoNDmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206410; c=relaxed/simple;
	bh=g0o1+h4XVJmiHEQStg7BnHda55VxhSyIuwGIQuqNFag=;
	h=From:Subject:To:Content-Type:Date:Message-ID; b=BSXwRXi+4Z5Jtn19IbFvCtjmUV9AivRJwwEIvUBo6ek8oaaGeDtM9v+/OmF9/tCTF8Vf8y5jOew8Y9xsuqaM5RYCpq4ONv9JkA1zPTOj1IKu1oEyJR29oek6fQrqZ103ZKzBRq5YV0yjBxLcVqe4iQkaKuKPazNIaUC+tD9sv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=parkerrandallperu.com; spf=pass smtp.mailfrom=ap-northeast-2.amazonses.com; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ZM6OCKop; arc=none smtp.client-ip=76.223.177.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=parkerrandallperu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-2.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cwxpcqz2jsbnzswvvpljj7cdg74la37w; d=amazonses.com; t=1739206407;
	h=From:Subject:To:Content-Type:Content-Transfer-Encoding:Reply-To:Date:Message-Id:Feedback-ID;
	bh=g0o1+h4XVJmiHEQStg7BnHda55VxhSyIuwGIQuqNFag=;
	b=ZM6OCKopF4zkEfoPLglfcLTEYbUUKDwy7myyVWBF6hKhxF5k46Rs97n6jMumbKZS
	xm7B8qcUsvwzuI7W3Y8Qy6Cz+HmldfP2Dph/NXGM+WNPQYZUWfUdLgfENzbFBUhwAlG
	wUlQ9W+yUas0wZ53vanbKBlG6w+TgS6SgoXVsLEc=
From: Anna <noreply@parkerrandallperu.com>
Subject: 2024 Tax Onboarding
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: anna@masterautorepair.onmicrosoft.com
Date: Mon, 10 Feb 2025 16:53:27 +0000
Message-ID: <010c0194f0c7b3af-dcfc5223-aa5d-4adb-8e0c-77cf8ebc4ded-000000@ap-northeast-2.amazonses.com>
Feedback-ID: ::1.ap-northeast-2.KW8w94y7TuIsdLhd3fp0zP+S1gmjQs+VlYTRXzpFl7I=:AmazonSES
X-SES-Outgoing: 2025.02.10-76.223.177.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hello,


Are you currently accepting new clients for individual tax return filing 
for the current year? My husband and I filed jointly for the 2023 tax year.


We're James and Anna Edwards, both travel therapists in the medical field, 
which means we frequently move for work. We found your contact information 
while searching through an online directory.


If you're available, I can send over our tax organizer and personal 
documents, including our W-2s, some 1040 details, and 1099 forms.


Please let me know how to proceed.

Best regards,
Anna Edwards


