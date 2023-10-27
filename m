Return-Path: <netdev+bounces-44638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328107D8DB1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C547281175
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D344411;
	Fri, 27 Oct 2023 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iUGSrNyQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F477440F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 04:02:51 +0000 (UTC)
X-Greylist: delayed 14170 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 21:02:49 PDT
Received: from out203-205-221-252.mail.qq.com (out203-205-221-252.mail.qq.com [203.205.221.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187671B3;
	Thu, 26 Oct 2023 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698379367; bh=KAZ2dqk5wzCasPZxhsxWQLln+2NhMGq3g10UXK4ZO3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iUGSrNyQAqeTayvopD/h7suMkCH4e4nYvAmLU0RcPAOvQtTW5ZTvYslHAC1uIY10y
	 nRgexwx2/sAjdfIbYu9AMRYNqy7S4ciDZbqDr4jTiSKe3gI2nEiAJaYa5h7GUPbszA
	 zNSR+KbukPNXHYWlCJQ2SmqELilD7c7iVT2cIoHk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id ACA321A; Fri, 27 Oct 2023 12:02:44 +0800
X-QQ-mid: xmsmtpt1698379364tqwcgbjse
Message-ID: <tencent_61372097D036524ACC74E176DF66043C2309@qq.com>
X-QQ-XMAILINFO: MFWpArBVhhGTL2fNDRRsjjukLOEVgOL+V7nknAYsrRaKxIzOvEDnTdjfV+mwVw
	 frkXq+jQrq4BkyznpjySOZW5HXzbQ0XLdEFguKD0URm65xb4cTaNNENSn8Cq2PlVPPXc8fwErjlK
	 54S8u7wdJ2fMICPNlo/905foAoOum740nS24u+8Eg3D1ltvlC1QUhbkAIH0mUV0/7CVK8NMB25eh
	 6Qmg588By03DQbJlTJOynEqs5ZOZg0WTkUXPNOOk+iabnty/2fOL3ZY/Szf3Fr1gJc6PstYwrYdZ
	 RYgP1v+mZ0DbPCd4MUWTB3eizEc+YJm837kgnw94pAyCAU8p4X0MjvIOvhgcgzkdIKjqV17iQXuW
	 kECt0cJugZzYnJwBgxNmnIpEPv+raSiD6DVHa6SKq4c4sau/BWZUwFHokOCFgKvAIi+a5RRPhi/w
	 o0lmgHFCllwgNug2dyhGFwvyH+X/GTIE2gFQHQnaZxRVS43B2arQ0RYHuuoHexIK+Vpumrbt+9DP
	 wrFhyBWVBM0m1EZxMeHkt6Q4W7plZuQ0LUUVR67zWP64L5I/niOTlA/UXbe42yHl9k46EJxrg+x9
	 R/y/mj/H6IqdN05Dq7VyL2ox/mssku/vU9d4HUKp5K0eyCrMpVO4isDLJDpjtvTAIsb7Ll9DAAdW
	 FrVIb/tWxnSF/jmgYiZQhVviY4KKr9DYDcpssK0cyyLwXyysJ1mfcROiK5bFKWegkQ94WNVGsll7
	 qRAhxoNCxJqDRvQSdHXx0nvDrhPZUsM0OuuPuxhzENm+dLwLmRgR/WG8dkjbvYXV8XZc6NtVSO+1
	 y41OOxH//NosRS4Jetf6sg6aj1596o243YSWp51U7Cpe2ZYnjDAu0zo3JfA/OqRQdReWAgyh9tdw
	 t6+t2J3C2CO5pNr1FddnKY5TfLW7dZcSdxcpdx3KsvmzrEYK104JhKeF/sWX94Hw6UwXDFqfo6AS
	 NQHQckIt0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	richardcochran@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next] ptp: ptp_read should not release queue
Date: Fri, 27 Oct 2023 12:02:45 +0800
X-OQ-MSGID: <20231027040244.3809048-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <tencent_541B3D2565BACCBBD133319E441B774B6C08@qq.com>
References: <tencent_541B3D2565BACCBBD133319E441B774B6C08@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **

This patch is not fix this issue, please ignore it.

edward


