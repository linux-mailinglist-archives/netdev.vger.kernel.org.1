Return-Path: <netdev+bounces-14668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD4D742E63
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 22:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97545280D65
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47488168B3;
	Thu, 29 Jun 2023 20:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6AF168AF
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:32:03 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE06830C4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:32:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-i-UpUp2gMSGmNxdPbJ99cw-1; Thu, 29 Jun 2023 16:30:09 -0400
X-MC-Unique: i-UpUp2gMSGmNxdPbJ99cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B05B5185A791;
	Thu, 29 Jun 2023 20:30:05 +0000 (UTC)
Received: from wsfd-netdev-vmhost.ntdv.lab.eng.bos.redhat.com (wsfd-netdev-vmhost.ntdv.lab.eng.bos.redhat.com [10.19.188.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2CEC478C7;
	Thu, 29 Jun 2023 20:30:05 +0000 (UTC)
From: Eric Garver <eric@garver.life>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 0/2] net: openvswitch: add drop action
Date: Thu, 29 Jun 2023 16:30:03 -0400
Message-Id: <20230629203005.2137107-1-eric@garver.life>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: garver.life
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
	FROM_SUSPICIOUS_NTLD_FP,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NEUTRAL,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prior to this series the "drop" action was implicit by an empty set of
actions. This series adds support for an explicit drop action. The
primary motivation is to allow passing xlate_error from userspace such
that xlater_error can be passed to kfree_skb_reason() and therefore
traced.                                                              =20

Eric Garver (2):
  net: openvswitch: add drop reasons
  net: openvswitch: add drop action

 include/net/dropreason.h                      |  6 ++++
 include/uapi/linux/openvswitch.h              |  2 ++
 net/openvswitch/actions.c                     | 13 +++++++
 net/openvswitch/datapath.c                    | 17 ++++++++++
 net/openvswitch/drop.h                        | 34 +++++++++++++++++++
 net/openvswitch/flow_netlink.c                | 12 ++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    |  3 ++
 7 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 net/openvswitch/drop.h

--=20
2.39.0


