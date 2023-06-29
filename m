Return-Path: <netdev+bounces-14678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078087430B4
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861E91C20B69
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FBF101DF;
	Thu, 29 Jun 2023 22:47:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9D101C8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 22:47:15 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F11BC2
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688078834; x=1719614834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z4DZUk4bC9zqB10uPLjcgH0wKZ/KReTVtEhniq3lETk=;
  b=juj21gm10neD1/isR4/usaXD+gvZYyWiLMPx0QBRGcfZrHow8xDA9OwH
   yXgDHCAc+uW/DF3IkgQ6gbVKlXv6q8wwbwn774lhh3kQHBSAGakgL/U1m
   QDjTSDUBUinHOVL18+7gaJn6J5rULsztHg3Ztk92SGTh/glrS29hGV+AO
   oAMQTRBUxhv/IfxN/4IkT1v9U8Q18U0nHS9m3bSAyJKp85PGgy8ajWpH8
   1rsEGBr0KPSmJaUl5IuanvbPpb8a3axQ4H/TcLbr/DovX+dStOx83j3A6
   al6kRqeMqcRU6zyW67QDltYiZh1aDJEaKE5Nb2utYOtPDT6JtKA9oHld2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="362287695"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="362287695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 15:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="747179630"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="747179630"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2023 15:47:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qF0Pl-000ESz-06;
	Thu, 29 Jun 2023 22:47:01 +0000
Date: Fri, 30 Jun 2023 06:46:30 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Garver <eric@garver.life>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net-next 2/2] net: openvswitch: add drop action
Message-ID: <202306300645.towwST4X-lkp@intel.com>
References: <20230629203005.2137107-3-eric@garver.life>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629203005.2137107-3-eric@garver.life>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Garver/net-openvswitch-add-drop-reasons/20230630-043307
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230629203005.2137107-3-eric%40garver.life
patch subject: [PATCH net-next 2/2] net: openvswitch: add drop action
config: mips-randconfig-r036-20230629 (https://download.01.org/0day-ci/archive/20230630/202306300645.towwST4X-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306300645.towwST4X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306300645.towwST4X-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/openvswitch/actions.c:1483:4: error: expected expression
                           u32 reason = nla_get_u32(a);
                           ^
>> net/openvswitch/actions.c:1485:4: error: use of undeclared identifier 'reason'
                           reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
                           ^
   net/openvswitch/actions.c:1488:8: error: use of undeclared identifier 'reason'
                           if (reason == OVS_XLATE_OK)
                               ^
   net/openvswitch/actions.c:1491:26: error: use of undeclared identifier 'reason'
                           kfree_skb_reason(skb, reason);
                                                 ^
   4 errors generated.


vim +1483 net/openvswitch/actions.c

  1285	
  1286	/* Execute a list of actions against 'skb'. */
  1287	static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
  1288				      struct sw_flow_key *key,
  1289				      const struct nlattr *attr, int len)
  1290	{
  1291		const struct nlattr *a;
  1292		int rem;
  1293	
  1294		for (a = attr, rem = len; rem > 0;
  1295		     a = nla_next(a, &rem)) {
  1296			int err = 0;
  1297	
  1298			if (trace_ovs_do_execute_action_enabled())
  1299				trace_ovs_do_execute_action(dp, skb, key, a, rem);
  1300	
  1301			switch (nla_type(a)) {
  1302			case OVS_ACTION_ATTR_OUTPUT: {
  1303				int port = nla_get_u32(a);
  1304				struct sk_buff *clone;
  1305	
  1306				/* Every output action needs a separate clone
  1307				 * of 'skb', In case the output action is the
  1308				 * last action, cloning can be avoided.
  1309				 */
  1310				if (nla_is_last(a, rem)) {
  1311					do_output(dp, skb, port, key);
  1312					/* 'skb' has been used for output.
  1313					 */
  1314					return 0;
  1315				}
  1316	
  1317				clone = skb_clone(skb, GFP_ATOMIC);
  1318				if (clone)
  1319					do_output(dp, clone, port, key);
  1320				OVS_CB(skb)->cutlen = 0;
  1321				break;
  1322			}
  1323	
  1324			case OVS_ACTION_ATTR_TRUNC: {
  1325				struct ovs_action_trunc *trunc = nla_data(a);
  1326	
  1327				if (skb->len > trunc->max_len)
  1328					OVS_CB(skb)->cutlen = skb->len - trunc->max_len;
  1329				break;
  1330			}
  1331	
  1332			case OVS_ACTION_ATTR_USERSPACE:
  1333				output_userspace(dp, skb, key, a, attr,
  1334							     len, OVS_CB(skb)->cutlen);
  1335				OVS_CB(skb)->cutlen = 0;
  1336				break;
  1337	
  1338			case OVS_ACTION_ATTR_HASH:
  1339				execute_hash(skb, key, a);
  1340				break;
  1341	
  1342			case OVS_ACTION_ATTR_PUSH_MPLS: {
  1343				struct ovs_action_push_mpls *mpls = nla_data(a);
  1344	
  1345				err = push_mpls(skb, key, mpls->mpls_lse,
  1346						mpls->mpls_ethertype, skb->mac_len);
  1347				break;
  1348			}
  1349			case OVS_ACTION_ATTR_ADD_MPLS: {
  1350				struct ovs_action_add_mpls *mpls = nla_data(a);
  1351				__u16 mac_len = 0;
  1352	
  1353				if (mpls->tun_flags & OVS_MPLS_L3_TUNNEL_FLAG_MASK)
  1354					mac_len = skb->mac_len;
  1355	
  1356				err = push_mpls(skb, key, mpls->mpls_lse,
  1357						mpls->mpls_ethertype, mac_len);
  1358				break;
  1359			}
  1360			case OVS_ACTION_ATTR_POP_MPLS:
  1361				err = pop_mpls(skb, key, nla_get_be16(a));
  1362				break;
  1363	
  1364			case OVS_ACTION_ATTR_PUSH_VLAN:
  1365				err = push_vlan(skb, key, nla_data(a));
  1366				break;
  1367	
  1368			case OVS_ACTION_ATTR_POP_VLAN:
  1369				err = pop_vlan(skb, key);
  1370				break;
  1371	
  1372			case OVS_ACTION_ATTR_RECIRC: {
  1373				bool last = nla_is_last(a, rem);
  1374	
  1375				err = execute_recirc(dp, skb, key, a, last);
  1376				if (last) {
  1377					/* If this is the last action, the skb has
  1378					 * been consumed or freed.
  1379					 * Return immediately.
  1380					 */
  1381					return err;
  1382				}
  1383				break;
  1384			}
  1385	
  1386			case OVS_ACTION_ATTR_SET:
  1387				err = execute_set_action(skb, key, nla_data(a));
  1388				break;
  1389	
  1390			case OVS_ACTION_ATTR_SET_MASKED:
  1391			case OVS_ACTION_ATTR_SET_TO_MASKED:
  1392				err = execute_masked_set_action(skb, key, nla_data(a));
  1393				break;
  1394	
  1395			case OVS_ACTION_ATTR_SAMPLE: {
  1396				bool last = nla_is_last(a, rem);
  1397	
  1398				err = sample(dp, skb, key, a, last);
  1399				if (last)
  1400					return err;
  1401	
  1402				break;
  1403			}
  1404	
  1405			case OVS_ACTION_ATTR_CT:
  1406				if (!is_flow_key_valid(key)) {
  1407					err = ovs_flow_key_update(skb, key);
  1408					if (err)
  1409						return err;
  1410				}
  1411	
  1412				err = ovs_ct_execute(ovs_dp_get_net(dp), skb, key,
  1413						     nla_data(a));
  1414	
  1415				/* Hide stolen IP fragments from user space. */
  1416				if (err)
  1417					return err == -EINPROGRESS ? 0 : err;
  1418				break;
  1419	
  1420			case OVS_ACTION_ATTR_CT_CLEAR:
  1421				err = ovs_ct_clear(skb, key);
  1422				break;
  1423	
  1424			case OVS_ACTION_ATTR_PUSH_ETH:
  1425				err = push_eth(skb, key, nla_data(a));
  1426				break;
  1427	
  1428			case OVS_ACTION_ATTR_POP_ETH:
  1429				err = pop_eth(skb, key);
  1430				break;
  1431	
  1432			case OVS_ACTION_ATTR_PUSH_NSH: {
  1433				u8 buffer[NSH_HDR_MAX_LEN];
  1434				struct nshhdr *nh = (struct nshhdr *)buffer;
  1435	
  1436				err = nsh_hdr_from_nlattr(nla_data(a), nh,
  1437							  NSH_HDR_MAX_LEN);
  1438				if (unlikely(err))
  1439					break;
  1440				err = push_nsh(skb, key, nh);
  1441				break;
  1442			}
  1443	
  1444			case OVS_ACTION_ATTR_POP_NSH:
  1445				err = pop_nsh(skb, key);
  1446				break;
  1447	
  1448			case OVS_ACTION_ATTR_METER:
  1449				if (ovs_meter_execute(dp, skb, key, nla_get_u32(a))) {
  1450					consume_skb(skb);
  1451					return 0;
  1452				}
  1453				break;
  1454	
  1455			case OVS_ACTION_ATTR_CLONE: {
  1456				bool last = nla_is_last(a, rem);
  1457	
  1458				err = clone(dp, skb, key, a, last);
  1459				if (last)
  1460					return err;
  1461	
  1462				break;
  1463			}
  1464	
  1465			case OVS_ACTION_ATTR_CHECK_PKT_LEN: {
  1466				bool last = nla_is_last(a, rem);
  1467	
  1468				err = execute_check_pkt_len(dp, skb, key, a, last);
  1469				if (last)
  1470					return err;
  1471	
  1472				break;
  1473			}
  1474	
  1475			case OVS_ACTION_ATTR_DEC_TTL:
  1476				err = execute_dec_ttl(skb, key);
  1477				if (err == -EHOSTUNREACH)
  1478					return dec_ttl_exception_handler(dp, skb,
  1479									 key, a);
  1480				break;
  1481	
  1482			case OVS_ACTION_ATTR_DROP:
> 1483				u32 reason = nla_get_u32(a);
  1484	
> 1485				reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
  1486						SKB_DROP_REASON_SUBSYS_SHIFT;
  1487	
  1488				if (reason == OVS_XLATE_OK)
  1489					break;
  1490	
  1491				kfree_skb_reason(skb, reason);
  1492				return 0;
  1493			}
  1494	
  1495			if (unlikely(err)) {
  1496				kfree_skb(skb);
  1497				return err;
  1498			}
  1499		}
  1500	
  1501		consume_skb(skb);
  1502		return 0;
  1503	}
  1504	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

