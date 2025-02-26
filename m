Return-Path: <netdev+bounces-169898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53620A46538
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D8118920D6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7021CC5B;
	Wed, 26 Feb 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ifurniture.co.nz header.i=@ifurniture.co.nz header.b="nYMQw4id"
X-Original-To: netdev@vger.kernel.org
Received: from o1.ptr3266.ifurniture.co.nz (o1.ptr3266.ifurniture.co.nz [149.72.82.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991DA59
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.82.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584358; cv=none; b=oaAg0QZ7/bVjXx45nPWsFAlvkMpnZv4a5FSEaDmG1kFmnvjuEvP64svi781yV7H6dY3oTcqiZk06MFqIYca4+IpffaIv8K02MCtci/9PhouP8yEJcl2U6xXKyz94Og4r1zL19jaVUMk1DzB+RPLvP8FlMz313ZibJj5XmA7p2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584358; c=relaxed/simple;
	bh=a8YxLONGSv5zivTtbWPDdPHNB4pdSIPqcLDIvn/5tBk=;
	h=Content-Type:From:Subject:Message-ID:Date:MIME-Version:To; b=f5Hl5K3WSoamJuDTB5EjyNt6y1hcENd6n/S8mG4Dve0w/XOCQeZfYkn6mlbuKUc5WG99YjoWLw7ZSEs4DZ7XHTeqPegeO8yN+OZc4dUiKw4smowrs6bGcY8DJqZppbb6/QmRC35D2Oja1ubFdibyshPXf2UO2PauSRRYq2xJZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ifurniture.co.nz; spf=pass smtp.mailfrom=em4445.ifurniture.co.nz; dkim=pass (2048-bit key) header.d=ifurniture.co.nz header.i=@ifurniture.co.nz header.b=nYMQw4id; arc=none smtp.client-ip=149.72.82.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ifurniture.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em4445.ifurniture.co.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifurniture.co.nz;
	h=content-type:from:subject:content-transfer-encoding:mime-version:
	reply-to:to:cc:content-type:from:subject:to;
	s=s1; bh=a8YxLONGSv5zivTtbWPDdPHNB4pdSIPqcLDIvn/5tBk=;
	b=nYMQw4idbCmaLLnuhQzQakDxOWWMBed/JhXlfmkQjnYVjQIUToZ8IDaZD/csfZdsqiH9
	UDCOQ8Fyy9rnow1tSv/JfTXQZTmGtJF7wqWj7/NXRbA/tWWqqL/pRzKDWMsmDsxlUeyvB+
	PLkbXJEtyvkHk205U+L/NXnf/sAo/kPU2Jw4+p9ingIB/wcovHdzz/vySHWzsUUH0uyeLP
	ZCqdUPiA2EHza5VTgr9KrAR6HvHvDCtp1zTfGjM1G80Fi/DpjTYhQ3IDNOuhooaEG7Sn9U
	FkUjdks/Q4RCpP9yOP+MHf0MYuwHbGKArLrTEEGrnz4yaGNBNqm5nOlT0QWIMZ8w==
Received: by recvd-7f7675ddcc-9669s with SMTP id recvd-7f7675ddcc-9669s-1-67BF35A3-37
	2025-02-26 15:39:15.403398659 +0000 UTC m=+3009858.749439763
Received: from [127.0.0.1] (unknown)
	by geopod-ismtpd-canary-0 (SG)
	with ESMTP id FylZ1RT_Q_-8n_e7fyMe_g
	for <netdev@vger.kernel.org>;
	Wed, 26 Feb 2025 15:39:15.269 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
From: Michelle <clive@ifurniture.co.nz>
Subject: -Inquiry Regarding 2024 Tax Return Preparation
Message-ID: <caa48eff-c43c-7c9e-48a6-fd56cc46c26b@ifurniture.co.nz>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2025 15:39:15 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: michelle@cestcorreoarch.onmicrosoft.com
X-SG-EID: 
 =?us-ascii?Q?u001=2EBfTmBDu8hufedufA6a1+vV=2FAbT6cV89PbuIPSU98NKAtEjpK1FF8Stdx0?=
 =?us-ascii?Q?mypfx7zDfQKC73prKliub6HhE9P6BPPgbVa2LY5?=
 =?us-ascii?Q?OsQCv6RuHTjAgisJAFbIyIEg5uy0pmNcDcmAx76?=
 =?us-ascii?Q?irWqqa9svOb3UiPyfa1jDOAo5lWzjbO19uy=2F5b8?=
 =?us-ascii?Q?5ENk7dVjbiw3ZeBNhAET9sGoxGJrTfQNNulrsT4?=
 =?us-ascii?Q?l+fUWRDCp7UuWXWiGItllKtWg00qqkrw3M712RD?= =?us-ascii?Q?RUJz?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.0ySc5hMBCXY9A2f3aq+yEw==

Hello,

I hope this message finds you well.

My husband and I are reaching out to inquire about your availability to tak=
e on new clients for the preparation of individual 1040 tax returns for the=
 current year. We filed jointly for the 2023 tax year.

We are Michelle and Patrick Hunt, both working as travel nurses, which mean=
s our professions often require us to relocate. We came across your contact=
 information while browsing the online directory for Certified Public Accou=
ntants (CPAs) and Enrolled Agents (EAs).

We understand that this is a busy time and are happy to be flexible with th=
e schedule. There=E2=80=99s no urgency on our end, so please let us know wh=
at timeline would work best for you. If necessary, we are open to being pla=
ced on an extension.

Could you kindly confirm if you are currently accepting new clients for tax=
 filing services? If so, we are ready to provide our tax organizer, persona=
l statement, and relevant documents such as W-2 forms, select 1040 details,=
 and 1099 forms. We can send these via secure Workdrive PDF or your portal =
today. Additionally, we would appreciate it if you could share the pricing =
details after reviewing our documents.

We look forward to hearing from you.

Best regards,
Michelle Hunt.

