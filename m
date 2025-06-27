Return-Path: <netdev+bounces-201853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D6AEB329
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D447560584
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4932293C7E;
	Fri, 27 Jun 2025 09:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE0293C6D;
	Fri, 27 Jun 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017362; cv=none; b=AyvB5Jm2Eh+ohuEv03wo0U9bRg/A6IOHVHhmr/Fq+0ahAXUAFjHJJ7AgDsG53q0L7ZzdKcOqV/OnM/O/CtX5tMZTNpzvInln5IxzJ7ldzo2L86t3KVVJF+kPIY2xy7TQkTJlxqVxvSfz9agzdWKuzS9szNFqwVARgE9YqQG+ThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017362; c=relaxed/simple;
	bh=FW8H1yTLwfSInktS6w4wMI6UITLNvwPfjgxjkrqzJ94=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRAGqGVHg5b8dKfF7HoY+qzRxCX17fDFDAsHgVRdMOpPvFxGEopW6MOroODMXj/BYyRdeSsMYaKmXooUYwGabtE1CHtB7H6iKr+Jc73rznEVpQAqfDfW9p0S2E/jNLK9lQdhD7DqhbJzsNSwNea1LW5x8PEny7uThmZLQD79nJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT9Yn1xY4z6M4td;
	Fri, 27 Jun 2025 17:41:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B79971402ED;
	Fri, 27 Jun 2025 17:42:37 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:42:37 +0200
Date: Fri, 27 Jun 2025 10:42:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Message-ID: <20250627104233.00005c5e@huawei.com>
In-Reply-To: <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-11-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 15:13:43 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
Typo in patch title.

