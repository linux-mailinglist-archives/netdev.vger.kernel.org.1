Return-Path: <netdev+bounces-288408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNEpEFtmB2oF1wIAu9opvQ
	(envelope-from <netdev+bounces-288408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:30:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEE75563CA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FDAE312280D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B423FDBF1;
	Fri, 15 May 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NT7YuBSg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894583F9A18;
	Fri, 15 May 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868126; cv=none; b=GV1PpY6NQKp0SsRjWQF4K/4fZiB/cKbez86PFc52Eexka9u8y8pgBLHDsTErbbO/vQzfvfxGmHsEP9D63NxZPoSI2yvc6mAjUPj+6lnHfWNjq7gBKc7oxIsjsihAXzwBixLWEcW9gh/MUbqcqGdCCR+hO9hBeuyqC8QFwWybdT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868126; c=relaxed/simple;
	bh=hRnoDvAySctmBMs8tnjE7No1NatjPvyW4KfMgZaPkZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY89sM4SeJ7edDAURUqces+Wjop2TSaRV8xIQFxtgudZSUMiUsv/Cv2qdZoe+zIS1MeOq1CmB89u+zSsN7OuT1pSyPDYVUcUkvLYG/NuUHxM2aFy23QHIDfODVbUV3oazWTvoQfYeyUaVGWM68ul9wShxs4h740m6NG8k3nBY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NT7YuBSg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778868124; x=1810404124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hRnoDvAySctmBMs8tnjE7No1NatjPvyW4KfMgZaPkZU=;
  b=NT7YuBSg5w0KTxIHrSr214L8PzMBC8P70JQTiuyOxahPRfs6n5hbhfM/
   ZsijbAzYY1YTKW50TDjUxw0JiAoFmYpb1j/L+NvnRLM+LqKtcJZVNeUVz
   C0Z0/0x6JyAi1bwrv9hp8D1+vj4smVfdFDwyPn6D8NLzZphwdH7DFYmZI
   YF+BkLcUAR0hcKja5ro3LUTnzxxuAUGE3amj7TGlkCveB54WrX/lSBaVk
   I587JvJo+YZBI7sLGdQqCTd7EBRMroFnPz9FklCIx5eGSHFPxhhjZnSbv
   YzJxgUi6qOBRTE4sOR9QLMk9OZzNFBbeHjm6XE8AevpSZ335bj2TcS9/m
   w==;
X-CSE-ConnectionGUID: p4u9r0qbSkSQH0r5FGVC7w==
X-CSE-MsgGUID: BlJNw5WkTWSM8CBfecl9gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83443339"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83443339"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:02:04 -0700
X-CSE-ConnectionGUID: AIqy9BIVRlKusO6DkR8VaA==
X-CSE-MsgGUID: 6mVg1JhcQTyjhLJxblj75A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="237892195"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 15 May 2026 11:02:01 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNwr1-000000002Th-1ypM;
	Fri, 15 May 2026 18:01:53 +0000
Date: Sat, 16 May 2026 02:01:08 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Yang <mmyangfl@gmail.com>,
	hong son Nguyen <hongson.hn@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: yt921x: Add ACL support
Message-ID: <202605160119.Kvm2K6nN-lkp@intel.com>
References: <20260514192140.3468543-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514192140.3468543-1-mmyangfl@gmail.com>
X-Rspamd-Queue-Id: ACEE75563CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,lunn.ch,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-288408-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url]
X-Rspamd-Action: no action

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/net-dsa-yt921x-Add-ACL-support/20260515-143825
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl%40gmail.com
patch subject: [PATCH net-next] net: dsa: yt921x: Add ACL support
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260516/202605160119.Kvm2K6nN-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260516/202605160119.Kvm2K6nN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605160119.Kvm2K6nN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/yt921x.c:1821:29: warning: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1821 |                         if (match.mask->ip_proto == ~0)
         |                             ~~~~~~~~~~~~~~~~~~~~ ^  ~~
   1 warning generated.


vim +1821 drivers/net/dsa/yt921x.c

  1581	
  1582	static int
  1583	yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
  1584					       const struct flow_cls_offload *cls)
  1585	{
  1586		const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
  1587		struct yt921x_acl_entry *entries = ruleext->r.entries;
  1588		struct netlink_ext_ack *extack = cls->common.extack;
  1589		const struct flow_dissector *dissector;
  1590		struct yt921x_acl_entry *entry;
  1591		unsigned int size = 0;
  1592		bool want_dport;
  1593		bool want_sport;
  1594	
  1595		/* Incomplete and probably won't, since it supports custom u32 filters.
  1596		 * New adapters are welcome.
  1597		 */
  1598		dissector = rule->match.dissector;
  1599		if (dissector->used_keys &
  1600		    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
  1601		      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
  1602		      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
  1603		      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
  1604		      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
  1605		      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
  1606		      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
  1607		      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
  1608		      BIT_ULL(FLOW_DISSECTOR_KEY_TCP))) {
  1609			NL_SET_ERR_MSG_MOD(extack, "Unsupported keys used");
  1610			return -EOPNOTSUPP;
  1611		}
  1612	
  1613		/* Entries */
  1614		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
  1615			struct flow_match_ipv4_addrs match;
  1616			bool want_dst;
  1617			bool want_src;
  1618	
  1619			flow_rule_match_ipv4_addrs(rule, &match);
  1620	
  1621			want_dst = !!match.mask->dst;
  1622			want_src = !!match.mask->src;
  1623	
  1624			if (want_dst) {
  1625				entry = yt921x_acl_entries_find(entries, &size,
  1626								YT921X_ACL_TYPE_IPV4_DA);
  1627				if (!entry)
  1628					goto err;
  1629	
  1630				entry->key[0] |= ntohl(match.key->dst);
  1631				entry->mask[0] |= ntohl(match.mask->dst);
  1632			}
  1633			if (want_src) {
  1634				entry = yt921x_acl_entries_find(entries, &size,
  1635								YT921X_ACL_TYPE_IPV4_SA);
  1636				if (!entry)
  1637					goto err;
  1638	
  1639				entry->key[0] |= ntohl(match.key->src);
  1640				entry->mask[0] |= ntohl(match.mask->src);
  1641			}
  1642		}
  1643	
  1644		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
  1645			struct flow_match_ipv6_addrs match;
  1646			bool want_dst;
  1647			bool want_src;
  1648	
  1649			flow_rule_match_ipv6_addrs(rule, &match);
  1650	
  1651			want_dst = !!match.mask->dst.s6_addr32[0] ||
  1652				   !!match.mask->dst.s6_addr32[1] ||
  1653				   !!match.mask->dst.s6_addr32[2] ||
  1654				   !!match.mask->dst.s6_addr32[3];
  1655			want_src = !!match.mask->src.s6_addr32[0] ||
  1656				   !!match.mask->src.s6_addr32[1] ||
  1657				   !!match.mask->src.s6_addr32[2] ||
  1658				   !!match.mask->src.s6_addr32[3];
  1659	
  1660			if (want_dst)
  1661				for (unsigned int i = 0; i < 4; i++) {
  1662					entry = yt921x_acl_entries_find(entries, &size,
  1663									YT921X_ACL_TYPE_IPV6_DA0 + i);
  1664					if (!entry)
  1665						goto err;
  1666	
  1667					entry->key[0] |= ntohl(match.key->dst.s6_addr32[i]);
  1668					entry->mask[0] |= ntohl(match.mask->dst.s6_addr32[i]);
  1669				}
  1670			if (want_src)
  1671				for (unsigned int i = 0; i < 4; i++) {
  1672					entry = yt921x_acl_entries_find(entries, &size,
  1673									YT921X_ACL_TYPE_IPV6_SA0 + i);
  1674					if (!entry)
  1675						goto err;
  1676	
  1677					entry->key[0] |= ntohl(match.key->src.s6_addr32[i]);
  1678					entry->mask[0] |= ntohl(match.mask->src.s6_addr32[i]);
  1679				}
  1680		}
  1681	
  1682		want_dport = false;
  1683		want_sport = false;
  1684		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
  1685			struct flow_match_ports match;
  1686	
  1687			entry = yt921x_acl_entries_find(entries, &size,
  1688							YT921X_ACL_TYPE_L4);
  1689			if (!entry)
  1690				goto err;
  1691	
  1692			flow_rule_match_ports(rule, &match);
  1693	
  1694			want_dport = !!match.mask->dst;
  1695			want_sport = !!match.mask->src;
  1696	
  1697			entry->key[0] |= (ntohs(match.key->dst) << 16) |
  1698					 ntohs(match.key->src);
  1699			entry->mask[0] |= (ntohs(match.mask->dst) << 16) |
  1700					  ntohs(match.mask->src);
  1701		}
  1702	
  1703		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
  1704			struct flow_match_ports_range match;
  1705	
  1706			entry = yt921x_acl_entries_find(entries, &size,
  1707							YT921X_ACL_TYPE_L4);
  1708			if (!entry)
  1709				goto err;
  1710	
  1711			flow_rule_match_ports_range(rule, &match);
  1712	
  1713			if ((want_dport && !!match.mask->tp.dst) ||
  1714			    (want_sport && !!match.mask->tp.src)) {
  1715				NL_SET_ERR_MSG_MOD(extack,
  1716						   "Ports and ports range are mutually exclusive");
  1717				return -EINVAL;
  1718			}
  1719	
  1720			entry->key[0] |= (ntohs(match.key->tp_min.dst) << 16) |
  1721					 ntohs(match.key->tp_min.src);
  1722			if (match.mask->tp.dst)
  1723				entry->key[1] |= YT921X_ACL_KEYb_L4_DPORT_RANGE_EN;
  1724			if (match.mask->tp.src)
  1725				entry->key[1] |= YT921X_ACL_KEYb_L4_SPORT_RANGE_EN;
  1726			entry->mask[0] |= (ntohs(match.mask->tp_max.dst) << 16) |
  1727					  ntohs(match.mask->tp_max.src);
  1728		}
  1729	
  1730		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
  1731			struct flow_match_eth_addrs match;
  1732			bool want_dst;
  1733			bool want_src;
  1734	
  1735			flow_rule_match_eth_addrs(rule, &match);
  1736	
  1737			want_dst = !is_zero_ether_addr(match.mask->dst);
  1738			want_src = !is_zero_ether_addr(match.mask->src);
  1739	
  1740			if (want_dst) {
  1741				entry = yt921x_acl_entries_find(entries, &size,
  1742								YT921X_ACL_TYPE_MAC_DA0);
  1743				if (!entry)
  1744					goto err;
  1745	
  1746				entry->key[0] |= ethaddr_hi4_to_u32(match.key->dst);
  1747				entry->mask[0] |= ethaddr_hi4_to_u32(match.mask->dst);
  1748			}
  1749			if (want_src) {
  1750				entry = yt921x_acl_entries_find(entries, &size,
  1751								YT921X_ACL_TYPE_MAC_SA0);
  1752				if (!entry)
  1753					goto err;
  1754	
  1755				entry->key[0] |= ethaddr_hi4_to_u32(match.key->src);
  1756				entry->mask[0] |= ethaddr_hi4_to_u32(match.mask->src);
  1757			}
  1758			if (want_src || want_dst) {
  1759				entry = yt921x_acl_entries_find(entries, &size,
  1760								YT921X_ACL_TYPE_MAC_DA1_SA1);
  1761				if (!entry)
  1762					goto err;
  1763	
  1764				entry->key[0] |= (ethaddr_lo2_to_u32(match.key->dst) << 16) |
  1765						 ethaddr_lo2_to_u32(match.key->src);
  1766				entry->mask[0] |= (ethaddr_lo2_to_u32(match.mask->dst) << 16) |
  1767						  ethaddr_lo2_to_u32(match.mask->src);
  1768			}
  1769		}
  1770	
  1771		/* Entries + Misc */
  1772		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
  1773			struct flow_match_basic match;
  1774	
  1775			flow_rule_match_basic(rule, &match);
  1776	
  1777			if (match.mask->n_proto) {
  1778				enum yt921x_l3_type type = YT921X_L3_TYPE_OTHER;
  1779	
  1780				if (match.mask->n_proto == htons(~0))
  1781					switch (match.key->n_proto) {
  1782					case htons(ETH_P_IP):
  1783						type = YT921X_L3_TYPE_IPV4;
  1784						break;
  1785					case htons(ETH_P_IPV6):
  1786						type = YT921X_L3_TYPE_IPV6;
  1787						break;
  1788					case htons(ETH_P_ARP):
  1789						type = YT921X_L3_TYPE_ARP;
  1790						break;
  1791					case htons(ETH_P_LLDP):
  1792						type = YT921X_L3_TYPE_LLDP;
  1793						break;
  1794					case htons(ETH_P_PAE):
  1795						type = YT921X_L3_TYPE_PAE;
  1796						break;
  1797					case htons(ETH_P_CFM):
  1798						type = YT921X_L3_TYPE_ERP;
  1799						break;
  1800					}
  1801	
  1802				if (type != YT921X_L3_TYPE_OTHER) {
  1803					size = yt921x_acl_entries_set_l3_type(entries,
  1804									      size,
  1805									      type);
  1806					if (!size)
  1807						goto err;
  1808				} else {
  1809					entry = yt921x_acl_entries_find(entries, &size,
  1810									YT921X_ACL_TYPE_ETHERTYPE);
  1811					if (!entry)
  1812						goto err;
  1813	
  1814					entry->key[0] |= ntohs(match.key->n_proto);
  1815					entry->mask[0] |= ntohs(match.mask->n_proto);
  1816				}
  1817			}
  1818			if (match.mask->ip_proto) {
  1819				enum yt921x_l4_type type = YT921X_L4_TYPE_OTHER;
  1820	
> 1821				if (match.mask->ip_proto == ~0)
  1822					switch (match.key->ip_proto) {
  1823					case IPPROTO_TCP:
  1824						type = YT921X_L4_TYPE_TCP;
  1825						break;
  1826					case IPPROTO_UDP:
  1827						type = YT921X_L4_TYPE_UDP;
  1828						break;
  1829					case IPPROTO_UDPLITE:
  1830						type = YT921X_L4_TYPE_UDPLITE;
  1831						break;
  1832					case IPPROTO_ICMP:
  1833						type = YT921X_L4_TYPE_ICMP;
  1834						break;
  1835					case IPPROTO_IGMP:
  1836						type = YT921X_L4_TYPE_IGMP;
  1837						break;
  1838					}
  1839	
  1840				if (type != YT921X_L4_TYPE_OTHER) {
  1841					size = yt921x_acl_entries_set_l4_type(entries,
  1842									      size,
  1843									      type);
  1844					if (!size)
  1845						goto err;
  1846				} else {
  1847					entry = yt921x_acl_entries_find(entries, &size,
  1848									YT921X_ACL_TYPE_MISC);
  1849					if (!entry)
  1850						goto err;
  1851	
  1852					entry->key[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.key->ip_proto);
  1853					entry->mask[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.mask->ip_proto);
  1854				}
  1855			}
  1856		}
  1857	
  1858		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
  1859			u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG;
  1860			struct flow_match_control match;
  1861	
  1862			flow_rule_match_control(rule, &match);
  1863			if (!flow_rule_is_supp_control_flags(supp_flags,
  1864							     match.mask->flags, extack))
  1865				return -EOPNOTSUPP;
  1866	
  1867			if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
  1868				bool set = match.key->flags & FLOW_DIS_FIRST_FRAG;
  1869	
  1870				size = yt921x_acl_entries_set_first_frag(entries, size,
  1871									 set);
  1872				if (!size)
  1873					goto err;
  1874			}
  1875			if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
  1876				bool set = match.key->flags & FLOW_DIS_IS_FRAGMENT;
  1877	
  1878				size = yt921x_acl_entries_set_is_fragment(entries, size,
  1879									  set);
  1880				if (!size)
  1881					goto err;
  1882			}
  1883		}
  1884	
  1885		/* Misc only */
  1886		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IP)) {
  1887			struct flow_match_ip match;
  1888	
  1889			flow_rule_match_ip(rule, &match);
  1890			if (match.mask->ttl)
  1891				return -EOPNOTSUPP;
  1892	
  1893			if (match.mask->tos) {
  1894				entry = yt921x_acl_entries_find(entries, &size,
  1895								YT921X_ACL_TYPE_MISC);
  1896				if (!entry)
  1897					goto err;
  1898	
  1899				entry->key[0] |= YT921X_ACL_BINa_MISC_TOS(match.key->tos);
  1900				entry->mask[0] |= YT921X_ACL_BINa_MISC_TOS(match.mask->tos);
  1901			}
  1902		}
  1903	
  1904		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_TCP)) {
  1905			struct flow_match_tcp match;
  1906	
  1907			flow_rule_match_tcp(rule, &match);
  1908	
  1909			if (match.mask->flags) {
  1910				entry = yt921x_acl_entries_find(entries, &size,
  1911								YT921X_ACL_TYPE_MISC);
  1912				if (!entry)
  1913					goto err;
  1914	
  1915				entry->key[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.key->flags));
  1916				entry->mask[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.mask->flags));
  1917			}
  1918		}
  1919	
  1920		if (!size) {
  1921			NL_SET_ERR_MSG_MOD(extack, "Empty rule generated, this should not happen");
  1922			return -EOPNOTSUPP;
  1923		}
  1924	
  1925		ruleext->r.mask = (1 << size) - 1;
  1926		return 0;
  1927	
  1928	err:
  1929		NL_SET_ERR_MSG_MOD(extack, "Rule too complex");
  1930		return -EOPNOTSUPP;
  1931	}
  1932	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

