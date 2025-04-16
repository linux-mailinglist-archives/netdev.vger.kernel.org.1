Return-Path: <netdev+bounces-183180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A66A8B4D4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8462F7A63FE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980C235360;
	Wed, 16 Apr 2025 09:07:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543BF236A66
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794471; cv=none; b=jggKnAJ833HnE4FQ27/GmuirizCyuBTTyxvdSwOWlp8lQprl4PvmjhQNfg5iE3oWjWhNT88CxWHi02C3zSR+2vFDuQ+jhZunLUFe+tDVzR0ZY5QJFhKcIZdQmg6TGKvM2QmRAOMj9kXcXHPi+Yw0TpN2eMCoJouiBcWOq0975E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794471; c=relaxed/simple;
	bh=Njn/JOJ02TKFaMDYncy3PGHKPsHcL4WUhCeJO8ZMXHw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSMYmUdfQownNN/222I+luOP2rSZp4jIMMQXWFLOVpPZuI9+wQ38fdufWGlvXa7zK916lLVsKjzJRy0rZovnqmWfQEvX9oXm6C4PniUWa0bsMoMxJrXE5BuN/XCpRSxDCFaSXjmeqmI0sYF2QbTK5awbbWtRj0Opp68rwK2xdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2340D2064C;
	Wed, 16 Apr 2025 11:07:46 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FX_KNSfCTwKz; Wed, 16 Apr 2025 11:07:45 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A073E20606;
	Wed, 16 Apr 2025 11:07:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A073E20606
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 16 Apr
 2025 11:07:45 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 11:07:44 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id BF02B3182C91; Wed, 16 Apr 2025 11:07:44 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:07:44 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Chiachang Wang <chiachangwang@google.com>
CC: <netdev@vger.kernel.org>, <leonro@nvidia.com>, <stanleyjhu@google.com>,
	<yumike@google.com>
Subject: Re: [PATCH ipsec-next v5 0/2] Update offload configuration with SA
Message-ID: <Z/9zYDpyiiA8dcaT@gauss3.secunet.de>
References: <20250313023641.1007052-1-chiachangwang@google.com>
 <CAOb+sWGK5ufBSBDkhXfwJTH+C9Jpa+0qCVvf=9RW1GQig9Vosw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOb+sWGK5ufBSBDkhXfwJTH+C9Jpa+0qCVvf=9RW1GQig9Vosw@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Tue, Apr 15, 2025 at 11:03:31AM +0800, Chiachang Wang wrote:
> Hi Steffen,
> 
> I understand you may be occupied by other works. I would like to reach
> out to you as this was uploaded for around a month.
> May I know if you have any review comment for this patchset ?

Sorry this got lost here. I'll look at the patchset now.

Thanks!

