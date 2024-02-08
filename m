Return-Path: <netdev+bounces-70134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2714284DC9D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8022282831
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 09:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492EC6BFC0;
	Thu,  8 Feb 2024 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buzzsy24.com header.i=@buzzsy24.com header.b="Eylzlp8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail.buzzsy24.com (mail.buzzsy24.com [80.211.148.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2BF6BB5C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.211.148.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383822; cv=none; b=IQaIT19o/6qf7cNiRoT4qv0RAKbMHuJyH1Fc3/o0Ek9JmEm/1SN/FCOF7Z2ZAlSfEgzxZzoEoWZnRXr1Dx+Sk5fA3mf9vFNDaBaiLxXvJMbmpuYzlG8yPc0Mk2EVgPPvEUZkAeWYpM7wQ+AJHgTZqoMtrnYHvm0k13CKT+xDuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383822; c=relaxed/simple;
	bh=ghCauvLksmmVwQ/dplRfNzDRLtlhT0nrJLOvIwiaySc=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=cCboM22D//I9kpAjl4F33YRn+FIjCBOOt5ZSuqZgj9YBzy4cjW474V+9hUHzToaA9p+6hqfhOxYcco7IUh5xlvx66PaEta+K6Sldba63+nVgpLBgkkZhrjvnprXgj4bM59j9GZv+5LIOQvUUvBpKcKy7WJQs8cKeeW7Tb+0pMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buzzsy24.com; spf=pass smtp.mailfrom=buzzsy24.com; dkim=pass (2048-bit key) header.d=buzzsy24.com header.i=@buzzsy24.com header.b=Eylzlp8j; arc=none smtp.client-ip=80.211.148.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buzzsy24.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buzzsy24.com
Received: by mail.buzzsy24.com (Postfix, from userid 1002)
	id 60C1982F90; Thu,  8 Feb 2024 10:10:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buzzsy24.com; s=mail;
	t=1707383468; bh=ghCauvLksmmVwQ/dplRfNzDRLtlhT0nrJLOvIwiaySc=;
	h=Date:From:To:Subject:From;
	b=Eylzlp8jp3FDVq42NpIRwkwgystvPanEcPq1DduWqdzTAwrem++ju3jD+519Y1Qqj
	 DgGWNeya6oLX9X0OeheCc7WVyeJ+sz+1Smr8lmWtjmDsQHlW3d4qFrrC8TCM+kewAk
	 gNbuGsttBIJqSpX4SnB9LqMzI6aImWUX7x/s7FQiEFsrKVuGcfSW7S9DeoC6OLqdZ8
	 7nhJn3zcPNLbfvJ8zzTmv20GuUw0PCK+aMT/34r+L+Uoz+3mQKsA3pVn4MpT+QirjI
	 7KbFx8tL8HpHuu849L+ERsf6wtbe8FvunTn9mdEzhkDv3ZQGqAF5EdtO04kIUKzvPE
	 Y4jycAfOXULSQ==
Received: by mail.buzzsy24.com for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 09:10:46 GMT
Message-ID: <20240208084500-0.1.s.1t2k.0.4dbdhlp56e@buzzsy24.com>
Date: Thu,  8 Feb 2024 09:10:46 GMT
From: "Benjamin Desaulniers" <benjamin.desaulniers@buzzsy24.com>
To: <netdev@vger.kernel.org>
Subject: Components for production
X-Mailer: mail.buzzsy24.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am writing to you on behalf of a company specializing in machining for =
enterprises that need the highest precision in detailing.

Our high-class cutting machines, laser and plasma cutting machines, MIG a=
nd MAG welding, as well as devices for machining and abrasive processing =
guarantee excellent results.

Thanks to high processing capacity, we ensure timely execution of orders,=
 cost optimization, repeatability and quick deliveries.

Can I present what we can do for you in this regard?


Best regards
Benjamin Desaulniers

