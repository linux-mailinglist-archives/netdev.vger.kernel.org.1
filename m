Return-Path: <netdev+bounces-13462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2073BAF5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC06281B50
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF7BAD24;
	Fri, 23 Jun 2023 15:01:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44DA95C
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:01:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E4E170E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687532512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paD23SqRCU3BAdfpZjI8QvlQvDMOZz4QBerkLVpXRi4=;
	b=RB+FY97znSlnCaXuvGyUCkNLErdY8/UGS1FCXFp0kup9eNEGRVi9zvasXUQmPUh7rsYmUx
	gY90Vyj+Jzw/+gOCMh2aoZ2/WxcSon7X0qe77Gx2A1z80yjBJe2Cjy/k1xqYolRuDI++8/
	j0jOOrE83idFQPknvG8AxRRROALXWYg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-cxKtgx3-Pd-7gJE_V0m8qA-1; Fri, 23 Jun 2023 11:01:47 -0400
X-MC-Unique: cxKtgx3-Pd-7gJE_V0m8qA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E60573C108EB;
	Fri, 23 Jun 2023 15:01:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C8CF0492B01;
	Fri, 23 Jun 2023 15:01:43 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bjorn.helgaas@gmail.com
Cc: Jinjian.Song@fibocom.com,
	Reid.he@fibocom.com,
	bjorn@helgaas.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	rafael.wang@fibocom.com,
	somashekhar.puttagangaiah@intel.com,
	jtornosm@redhat.com
Subject: Re: [v5,net-next]net: wwan: t7xx : V5 ptach upstream work
Date: Fri, 23 Jun 2023 17:01:42 +0200
Message-ID: <20230623150142.292838-1-jtornosm@redhat.com>
In-Reply-To: <CABhMZUXyY6-cnxPcU5MFy2-RoVuCx65PUVwMKsM5gqhgtdNy2Q@mail.gmail.com>
References: <CABhMZUXyY6-cnxPcU5MFy2-RoVuCx65PUVwMKsM5gqhgtdNy2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I have a proposal because at this moment with the current status, t7xx is not
functional due to problems like this if there is no activity:
[   57.370534] mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
[   57.370581] mtk_t7xx 0000:72:00.0: can't suspend
    (t7xx_pci_pm_runtime_suspend [mtk_t7xx] returned -110)
and after this the traffic is not working.

As yu know the situation was stalled and it seems that the final solution for
the complete series can take longer, so in order to have at least the modem
working, it would be enough if just the first commit of the series is
re-applied (d20ef656f994 net: wwan: t7xx: Add AP CLDMA). With that, the
Application Processor would be controlled, correctly suspended and the
commented problems would be fixed (I am testing here like this with no related
issue).

I think the first commit of the series is independent of the others and it can
be re-applied cleanly. Later on, the other commits related to fw flashing and 
coredump collection new features could be added taking into account Bjorn's 
comments (and of course updated doc if needed).

Thanks
Jose Ignacio


